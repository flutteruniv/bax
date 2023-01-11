import 'package:bax/features/map/application/map_service.dart';
import 'package:bax/features/measurement_wifi/presentation/measure_wifi_speed_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../common_widgets/bax_indicator.dart';
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

  final LatLng _center = const LatLng(35.65896199999999, 139.7481391);

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    ref.read(mapServiceProvider).setupMap();
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
    return ref.watch(facilitiesStreamProvider).when(
      data: (facilities) {
        return GestureDetector(
          onTap: () => primaryFocus?.unfocus(),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Stack(
              children: [
                GoogleMap(
                  onMapCreated: onMapCreated,
                  markers: facilities.map((facility) => facility.getMarker).toSet(),
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
      },
      error: (error, stackTrace) {
        return const SizedBox();
      },
      loading: () {
        return const BaxIndicator();
      },
    );
  }
}
