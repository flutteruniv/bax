import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../facility/data/facility_repository.dart';
import '../../location/domain/my_location.dart';
import '../../measurement_wifi/presentation/measure_wifi_speed_page.dart';
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
                markers: facilities.map((facility) => facility.data().getMarker).toSet(),
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
