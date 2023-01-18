import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'selected_location_info.freezed.dart';

@freezed
class SelectedLocationInfo with _$SelectedLocationInfo {
  const factory SelectedLocationInfo({
    required String facilityId,
    required String name,
    required LatLng latLng,
    required bool hasMeasurementResult,
  }) = _SelectedLocationInfo;
}
