import 'package:bax/features/map/domain/geocoding_results/geocoding_result.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'geocoding_results.freezed.dart';
part 'geocoding_results.g.dart';

@freezed
class GeocodingResults with _$GeocodingResults {
  const factory GeocodingResults({
    required List<GeocodingResult> results,
  }) = _GeocodingResults;

  factory GeocodingResults.fromJson(Map<String, dynamic> json) => _$GeocodingResultsFromJson(json);
}
