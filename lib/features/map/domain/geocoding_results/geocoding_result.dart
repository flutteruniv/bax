import 'package:freezed_annotation/freezed_annotation.dart';

import '../geometry/geometry.dart';

part 'geocoding_result.freezed.dart';
part 'geocoding_result.g.dart';

@freezed
class GeocodingResult with _$GeocodingResult {
  const factory GeocodingResult({
    required Geometry geometry,
  }) = _GeocodingResult;

  factory GeocodingResult.fromJson(Map<String, dynamic> json) => _$GeocodingResultFromJson(json);
}
