import 'package:freezed_annotation/freezed_annotation.dart';

part 'wifi_measurement_result.freezed.dart';
part 'wifi_measurement_result.g.dart';

@freezed
class WifiMeasurementResult with _$WifiMeasurementResult {
  const factory WifiMeasurementResult({
    required double downloadSpeedMbps,
    required double uploadSpeedMbps,
    required String ssid,
  }) = _WifiMeasurementResult;

  factory WifiMeasurementResult.fromJson(Map<String, dynamic> json) => _$WifiMeasurementResultFromJson(json);
}
