import 'dart:developer';

import 'package:bax/features/map/application/map_service.dart';
import 'package:bax/features/measurement_wifi/presentation/measure_wifi_speed_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'widgets/search_text_form_field.dart';

class FacilityMapPage extends ConsumerStatefulWidget {
  const FacilityMapPage({super.key});

  static const route = '/';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FacilityMapPageState();
}

class _FacilityMapPageState extends ConsumerState<FacilityMapPage> {
  final controller = TextEditingController();

  late GoogleMapController mapController;

  final LatLng _center = const LatLng(45.521563, -122.677433);

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    ref.read(mapServiceProvider).fetchFacilities();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mapService = ref.watch(facilitiesProvider);

    /// test
    final stream = mapService.when(
      data: (facilities) {
        facilities.forEach(print);
      },
      error: (error, stackTrace) {},
      loading: () {},
    );

    return GestureDetector(
      onTap: () => primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            GoogleMap(
              onMapCreated: onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 11,
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SearchTextFormField(
                  controller: controller,
                ),
              ),
            )
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
