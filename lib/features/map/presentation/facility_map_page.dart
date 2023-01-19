import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../facility/data/facility_repository.dart';
import '../../location/domain/my_location.dart';
import '../../measurement_wifi/presentation/measure_wifi_speed_page.dart';
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
  late GoogleMapController mapController;

  final searchTextEditingController = TextEditingController();

  // final _center = const LatLng(35.65896199999999, 139.7481391);

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  bool get shouldShowPredicationResultList => searchTextEditingController.text.isNotEmpty;

  final Set<Marker> markers = {};

  @override
  void initState() {
    searchTextEditingController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    searchTextEditingController.dispose();
    mapController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  late final focusNode = FocusNode()
    ..addListener(() {
      setState(() {});
    });

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
      final locationInfo = next.value;
      if (locationInfo == null) {
        return;
      }

      // マップの中心位置を移動する
      await mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: locationInfo.latLng, zoom: 14),
        ),
      );
      // 検索クリアー
      searchTextEditingController.text = '';
      primaryFocus?.unfocus();

      if (!locationInfo.hasMeasurementResult) {
        // 未測定の場合はMarkerがないので未測定Markerを設置する
        final marker = Marker(
          markerId: MarkerId(locationInfo.facilityId),
          position: locationInfo.latLng,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
          infoWindow: InfoWindow(title: locationInfo.name, snippet: 'Wifiダウンロード速度: 未測定'),
        );
        markers.add(marker);
      }

      // 追加したMarkerが描画されるのを一瞬待ってからMarkerInfoを表示する
      Future.delayed(const Duration(milliseconds: 100), () async {
        await mapController.showMarkerInfoWindow(MarkerId(locationInfo.facilityId));
      });
    });

    final location = ref.watch(locationDataProvider).valueOrNull;

    return GestureDetector(
      onTap: () {
        primaryFocus?.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            if (location != null)
              GoogleMap(
                onMapCreated: onMapCreated,
                markers: markers,
                initialCameraPosition: CameraPosition(
                  target: LatLng(location.latitude!, location.longitude!),
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.go(FacilityMapPage.route + MeasureWiFiSpeedPage.route);
          },
          child: const Icon(
            Icons.network_check,
          ),
        ),
      ),
    );
  }
}
