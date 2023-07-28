import 'dart:async';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../configs/localizations.dart';
import '../../authentication/application/auth_service.dart';
import '../../facility/data/facility_repository.dart';
import '../../facility/presentation/facility_page.dart';
import '../../location/domain/my_location.dart';
import '../../measurement_wifi/presentation/measure_wifi_speed_page.dart';
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

class _FacilityMapPageState extends ConsumerState<FacilityMapPage> with WidgetsBindingObserver {
  final mapControllerCompleter = Completer<GoogleMapController>();

  final searchTextEditingController = TextEditingController();

  Position? position;

  bool get shouldShowPredicationResultList => searchTextEditingController.text.isNotEmpty;

  final Set<Marker> markers = {};

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
    final position = await ref.refresh(initLocationProvider.future);
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
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (AppLifecycleState.resumed == state) {
      fetchLocationDataAndMoveCamera();
    }
  }

  StreamSubscription<PendingDynamicLinkData>? sub;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    searchTextEditingController.addListener(() {
      setState(() {});
    });
    fetchLocationDataAndMoveCamera();

    // FDLの監視。リンクを踏んでアプリを起動したときに処理が走る。
    sub = FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) async {
      await ref.watch(authServiceProvider).linkWithCredentialByEmailLink(dynamicLinkData.link.toString());
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    searchTextEditingController.dispose();
    mapControllerCompleter.future.then((value) => value.dispose());
    focusNode.dispose();
    sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = ref.watch(localizationsProvider);
    final facilities = ref.watch(facilitiesStreamProvider).valueOrNull ?? [];
    final isPro = ref.watch(isProProvider);
    markers.addAll(
      facilities.map((facility) {
        final data = facility.data();
        return Marker(
          markerId: MarkerId(data.id),
          position: LatLng(data.geo.latitude, data.geo.longitude),
          icon: isPro ? BitmapDescriptor.defaultMarkerWithHue(data.markerColor) : BitmapDescriptor.defaultMarker,
          onTap: () {
            // TODO(kenta-wakasa): 施設詳細画面に遷移する
            context.go('${FacilityMapPage.route}${FacilityPage.route}/${facility.id}');
          },
        );
      }).toSet(),
    );

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

      if (facility.downloadSpeed == 0) {
        // 未測定の場合はMarkerがないので未測定Markerを設置する
        final marker = Marker(
          markerId: MarkerId(facility.id),
          position: latlng,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
          infoWindow: InfoWindow(title: facility.name, snippet: '${l.downloadSpeed}: ${l.notMeasured}'),
        );
        markers.add(marker);
      }

      // 追加したMarkerが描画されるのを一瞬待ってからMarkerInfoを表示する
      Future.delayed(const Duration(milliseconds: 100), () async {
        await mapController.showMarkerInfoWindow(MarkerId(facility.id));
      });
    });

    return GestureDetector(
      onTap: () {
        primaryFocus?.unfocus();
      },
      child: AnnotatedRegion(
        value: const SystemUiOverlayStyle(
          /// Android のステータスバーアイコンの色が変更される
          statusBarIconBrightness: Brightness.light,

          /// iOS のステータスバーの文字色が変更される
          statusBarBrightness: Brightness.light,
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
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
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24),
                      SearchTextFormField(
                        controller: searchTextEditingController,
                        focusNode: focusNode,
                      ),
                      const SizedBox(height: 8),
                      if (shouldShowPredicationResultList) const PredicationResultList(),
                    ],
                  ),
                ),
              ),

              /// 所持BAX
              Align(
                alignment: Alignment.topRight,
                child: SafeArea(
                  child: InkWell(
                    onTap: () {
                      context.go('${FacilityMapPage.route}${MyPage.route}');
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 16),
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
                ),
              ),
            ],
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
