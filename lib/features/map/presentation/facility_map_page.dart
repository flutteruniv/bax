import 'package:bax/features/map/presentation/widgets/prediction_result_list.dart';
import 'package:bax/features/measurement_wifi/presentation/measure_wifi_speed_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../facility/data/facility_repository.dart';
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

  final _center = const LatLng(35.65896199999999, 139.7481391);

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void dispose() {
    controller.dispose();
    mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final facilities = ref.watch(facilitiesStreamProvider).valueOrNull ?? [];
    return GestureDetector(
      onTap: () => primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            GoogleMap(
              onMapCreated: onMapCreated,
              markers: facilities.map((facility) => facility.data().getMarker).toSet(),
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 11,
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    SearchTextFormField(
                      controller: controller,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: PredicationResultList(),
                    ),
                  ],
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
