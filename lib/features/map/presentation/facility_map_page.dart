import 'dart:async';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../configs/localizations.dart';
import '../../authentication/application/auth_service.dart';
import '../../facility/data/facility_repository.dart';
import '../../facility/presentation/facility_details_widget.dart';
import '../../location/domain/my_location.dart';
import '../../measurement_wifi/presentation/measure_wifi_speed_page.dart';
import '../../payment/presentation/payment_dialog.dart';
import '../../payment/repository/payment_repository.dart';
import '../../user/application/user_service.dart';
import '../../user/presentation/my_page.dart';
import '../application/map_service.dart';
import 'widgets/prediction_result_list.dart';
import 'widgets/search_text_form_field.dart';

class FacilityMapPage extends ConsumerStatefulWidget {
  const FacilityMapPage({super.key});

  static const route = '/';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FacilityMapPageState();
}

class _FacilityMapPageState extends ConsumerState<FacilityMapPage> {
  final mapControllerCompleter = Completer<GoogleMapController>();
  final searchTextEditingController = TextEditingController();
  Position? position;
  bool get shouldShowPredicationResultList => searchTextEditingController.text.isNotEmpty;
  Set<Marker> markers = <Marker>{};
  StreamSubscription<PendingDynamicLinkData>? subDynamicLinks;
  final slideUpPanelController = ScrollController();

  /// 検索結果のマーカー
  Marker? searchedMarker;
  bool hasPowerSpot = false;

  late final focusNode = FocusNode()
    ..addListener(() {
      setState(() {});
    });

  Future<void> onMapCreated(GoogleMapController controller) async {
    mapControllerCompleter.complete(controller);
    final value = await DefaultAssetBundle.of(context).loadString('assets/map_style_silver.json');
    await controller.setMapStyle(value);
  }

  Future<void> fetchLocationDataAndMoveCamera() async {
    position = await ref.refresh(locationProvider.future);
    final mapController = await mapControllerCompleter.future;
    final latitude = position?.latitude;
    final longitude = position?.longitude;
    if (latitude == null || longitude == null) {
      return;
    }
    await mapController.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(latitude, longitude),
          zoom: 16,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    searchTextEditingController.addListener(() {
      setState(() {});
    });
    fetchLocationDataAndMoveCamera();

    // FDLの監視。リンクを踏んでアプリを起動したときに処理が走る。
    subDynamicLinks = FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) async {
      // TODO(kenta-wakasa): 毎回認証リンクとは限らないはずなので、その辺りをハンドリングする仕組みが必要そう
      await ref.watch(authServiceProvider).linkWithCredentialByEmailLink(dynamicLinkData.link.toString());
    });
  }

  @override
  void dispose() {
    searchTextEditingController.dispose();
    mapControllerCompleter.future.then((value) => value.dispose());
    focusNode.dispose();
    subDynamicLinks?.cancel();
    slideUpPanelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = ref.watch(localizationsProvider);
    final facilities = ref.watch(facilitiesStreamProvider).valueOrNull ?? [];
    final isPro = ref.watch(isProProvider);
    final selectedFacility = ref.watch(selectedFacilityProvider);

    const radius = BorderRadius.only(
      topLeft: Radius.circular(16),
      topRight: Radius.circular(16),
    );

    markers = facilities.where((element) => element.data().downloadSpeed != 0.0).map((qds) {
      final facility = qds.data();
      return Marker(
        markerId: MarkerId(facility.id),
        position: LatLng(facility.geo.latitude, facility.geo.longitude),
        icon: isPro
            ? BitmapDescriptor.defaultMarkerWithHue(facility.markerColor)
            : BitmapDescriptor.defaultMarkerWithHue(30),
        onTap: () {
          ref.read(selectedPlaceIdProvider.notifier).update((state) => facility.id);
        },
      );
    }).toSet();

    /// 検索結果のマーカーを足す
    if (searchedMarker != null) {
      markers.add(searchedMarker!);
    }

    /// 電源あり以外のマーカーを取り除く
    if (hasPowerSpot) {
      for (final facility in facilities) {
        if (facility.data().haaPowerSpot != true) {
          markers.removeWhere((element) => element.markerId.value == facility.id);
        }
      }
    }

    ref.listen(selectedLocationInfoStreamProvider, (previous, next) async {
      final facility = next.value;
      if (facility == null) {
        return;
      }
      final latlng = LatLng(facility.geo.latitude, facility.geo.longitude);

      final mapController = await mapControllerCompleter.future;

      // マップの中心位置を移動する
      await mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: latlng,
            zoom: 16,
          ),
        ),
      );
      // 検索クリアー
      searchTextEditingController.text = '';
      primaryFocus?.unfocus();

      ref.read(selectedPlaceIdProvider.notifier).update((state) => facility.id);

      if (facility.downloadSpeed == 0) {
        // 未測定の場合はMarkerがないので未測定Markerを設置する
        searchedMarker = Marker(
          markerId: MarkerId(facility.id),
          position: latlng,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
          onTap: () {
            ref.read(selectedPlaceIdProvider.notifier).update((state) => facility.id);
          },
        );
        markers.add(searchedMarker!);
      }

      // 追加したMarkerが描画されるのを一瞬待ってからMarkerInfoを表示する
      // Future.delayed(const Duration(milliseconds: 100), () async {
      //   await mapController.showMarkerInfoWindow(MarkerId(facility.id));
      // });
    });

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: GestureDetector(
        onTap: () => primaryFocus?.unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SlidingUpPanel(
            renderPanelSheet: false, //selectedFacilitySnapshot != null,
            borderRadius: radius,
            maxHeight: MediaQuery.sizeOf(context).height - MediaQuery.of(context).viewPadding.top,
            snapPoint: .3,
            minHeight: 180,
            panelBuilder: (controller) {
              if (selectedFacility == null) {
                return const SizedBox();
              }
              return DecoratedBox(
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: radius,
                ),
                child: FacilityDetailsWidget(
                  docId: selectedFacility.id,
                  controller: controller,
                ),
              );
            },
            body: Stack(
              children: [
                GoogleMap(
                  myLocationButtonEnabled: false,
                  onMapCreated: onMapCreated,
                  markers: markers,
                  initialCameraPosition: CameraPosition(
                    /// 初期値を東京駅にしています。
                    target: LatLng(
                      position?.latitude ?? 35.6812362,
                      position?.longitude ?? 139.7649361,
                    ),
                    zoom: 16,
                  ),
                  mapToolbarEnabled: false,
                  zoomControlsEnabled: false,
                  myLocationEnabled: true,
                ),
                if (focusNode.hasFocus) Container(color: Colors.transparent),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                if (isPro) {
                                  setState(() {
                                    hasPowerSpot = !hasPowerSpot;
                                  });
                                } else {
                                  PaymentDialog.showFullScreenDialog(context);
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(80)),
                                  color: Colors.white,
                                  border: hasPowerSpot ? Border.all(color: Colors.yellow[900]!) : null,
                                  boxShadow: const [
                                    BoxShadow(
                                      offset: Offset(1, 1),
                                      blurRadius: .1,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.power_outlined,
                                      size: 16,
                                      color: hasPowerSpot ? Colors.yellow[900]! : null,
                                    ),
                                    Text(
                                      l.hasPowerSeats,
                                      style: hasPowerSpot
                                          ? TextStyle(
                                              color: Colors.yellow[900]!,
                                            )
                                          : null,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                context.go('${FacilityMapPage.route}${MyPage.route}');
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(80)),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(1, 1),
                                      blurRadius: .1,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/bax_logo.svg',
                                      width: 12,
                                      color: Colors.black,
                                    ),
                                    const SizedBox(width: 8),
                                    Text('${ref.watch(userBaxProvider)}'),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        /// 検索フォーム
                        SearchTextFormField(
                          controller: searchTextEditingController,
                          focusNode: focusNode,
                        ),
                        const SizedBox(height: 8),
                        if (shouldShowPredicationResultList)
                          PredicationResultList(
                            onTap: (predictionResult) {
                              ref.read(mapServiceProvider).geocoding(
                                    predictionResult.placeId,
                                    predictionResult.resultFormatting.name,
                                    predictionResult.resultFormatting.address,
                                  );
                            },
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FloatingActionButton(
                onPressed: () {
                  context.goNamed(MeasureWiFiSpeedPage.name);
                },
                child: const Icon(
                  Icons.network_check,
                ),
              ),
              const SizedBox(height: 16),
              FloatingActionButton(
                onPressed: fetchLocationDataAndMoveCamera,
                child: const Icon(
                  Icons.near_me,
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
