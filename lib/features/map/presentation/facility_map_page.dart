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

  final Set<Marker> markers = {};

  late final focusNode = FocusNode()
    ..addListener(() {
      setState(() {});
    });

  void onMapCreated(GoogleMapController controller) {
    mapControllerCompleter.complete(controller);
  }

  Future<void> fetchLocationDataAndMoveCamera() async {
    position = await ref.read(initLocationProvider.future);
    final mapController = await mapControllerCompleter.future;
    final latitude = position?.latitude;
    final longitude = position?.longitude;
    if (latitude == null || longitude == null) {
      return;
    }
    await mapController.moveCamera(CameraUpdate.newLatLng(LatLng(latitude, longitude)));
  }

  @override
  void initState() {
    searchTextEditingController.addListener(() {
      setState(() {});
    });
    fetchLocationDataAndMoveCamera();

    // FDL????????????????????????????????????????????????????????????????????????????????????
    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) async {
      await ref.watch(authServiceProvider).authenticateEmail(dynamicLinkData.link.toString());
    });
    super.initState();
  }

  @override
  void dispose() {
    searchTextEditingController.dispose();
    mapControllerCompleter.future.then((value) => value.dispose());
    focusNode.dispose();
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
          infoWindow: InfoWindow(title: data.name, snippet: 'Wifi????????????????????????: ${data.downloadSpeed}Mbps'),
          onTap: () {
            /// TODO: ?????????????????????????????????
          },
        );
      }).toSet(),
    );

    ref.listen(selectedLocationInfoStreamProvider, (previous, next) async {
      final locationInfo = next.value;
      if (locationInfo == null) {
        return;
      }

      final mapController = await mapControllerCompleter.future;

      // ???????????????????????????????????????
      await mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: locationInfo.latLng, zoom: 16),
        ),
      );
      // ??????????????????
      searchTextEditingController.text = '';
      primaryFocus?.unfocus();

      if (!locationInfo.hasMeasurementResult) {
        // ?????????????????????Marker????????????????????????Marker???????????????
        final marker = Marker(
          markerId: MarkerId(locationInfo.facilityId),
          position: locationInfo.latLng,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
          infoWindow: InfoWindow(title: locationInfo.name, snippet: 'Wifi????????????????????????: ?????????'),
        );
        markers.add(marker);
      }

      // ????????????Marker?????????????????????????????????????????????MarkerInfo???????????????
      Future.delayed(const Duration(milliseconds: 100), () async {
        await mapController.showMarkerInfoWindow(MarkerId(locationInfo.facilityId));
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
                /// ??????????????????????????????????????????
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

            /// FIXME: GoogleMap???????????????GestureDetecter??????????????????????????????????????????????????????????????????
            ///
            /// ????????????????????????????????????Container?????????????????????????????????????????????????????????
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
          ],
        ),
      ),
    );
  }
}
