import 'dart:async';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../authentication/application/auth_service.dart';
import '../../authentication/presentation/email_authentication_page.dart';
import '../../facility/data/facility_repository.dart';
import '../../location/domain/my_location.dart';
import '../../measurement_wifi/presentation/measure_wifi_speed_page.dart';
import '../../payment/repository/payment_repository.dart';
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

  void onMapCreated(GoogleMapController controller) {
    mapControllerCompleter.complete(controller);
  }

  Future<void> fetchLocationDataAndMoveCamera() async {
    final position = await ref.refresh(initLocationProvider.future);
    final mapController = await mapControllerCompleter.future;
    final latitude = position?.latitude;
    final longitude = position?.longitude;
    if (latitude == null || longitude == null) {
      return;
    }
    await mapController.moveCamera(CameraUpdate.newLatLng(LatLng(latitude, longitude)));
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (AppLifecycleState.resumed == state) {
      fetchLocationDataAndMoveCamera();
    }
  }

  StreamSubscription? sub;

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
    final facilities = ref.watch(facilitiesStreamProvider).valueOrNull ?? [];
    markers.addAll(
      facilities.map((facility) {
        final data = facility.data();
        return Marker(
          markerId: MarkerId(data.id),
          position: LatLng(data.geo.latitude, data.geo.longitude),
          icon: BitmapDescriptor.defaultMarkerWithHue(data.markerColor),
          infoWindow: InfoWindow(title: data.name, snippet: 'Wifiダウンロード速度: ${data.downloadSpeed}Mbps'),
          onTap: () {
            /// TODO: 施設詳細画面に遷移する
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
          infoWindow: InfoWindow(title: facility.name, snippet: 'Wifiダウンロード速度: 未測定'),
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
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            GoogleMap(
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

            /// FIXME: GoogleMapに干渉してGestureDetecterが反応せず、キーボードを閉じることができない
            ///
            /// そのため、入力中は透明なContainerを表示させることでいったんお茶を濁す。
            if (focusNode.hasFocus)
              // ignore: use_colored_box
              Container(
                color: Colors.transparent,
              ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
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
          ],
        ),
        floatingActionButton: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FloatingActionButton(
              onPressed: fetchLocationDataAndMoveCamera,
              child: const Icon(
                Icons.near_me,
              ),
            ),
            const SizedBox(height: 16),
            FloatingActionButton(
              onPressed: () {
                context.go(FacilityMapPage.route + MeasureWiFiSpeedPage.route);
              },
              child: const Icon(
                Icons.network_check,
              ),
            ),
            const SizedBox(height: 16),
            FloatingActionButton(
              onPressed: () {
                context.go(FacilityMapPage.route + EmailAuthenticationPage.route);
              },
              child: const Icon(
                Icons.mail,
              ),
            ),
            const SizedBox(height: 16),
            FloatingActionButton(
              onPressed: () async {
                await ref.read(paymentRepositoryProvider).purchaseSubscription();
              },
              child: const Icon(Icons.payment),
            ),
            const SizedBox(height: 16),
            FloatingActionButton(
              onPressed: () {
                context.go(FacilityMapPage.route + MyPage.route);
              },
              child: const Icon(Icons.person),
            ),
          ],
        ),
      ),
    );
  }
}
