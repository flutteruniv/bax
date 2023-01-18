import 'package:freezed_annotation/freezed_annotation.dart';

import 'geocoding_result.dart';

part 'geocoding_results.freezed.dart';
part 'geocoding_results.g.dart';

@freezed
class GeocodingResults with _$GeocodingResults {
  const factory GeocodingResults({
    required List<GeocodingResult> results,
  }) = _GeocodingResults;

  factory GeocodingResults.fromJson(Map<String, dynamic> json) => _$GeocodingResultsFromJson(json);
}
