import 'package:bax/features/map/domain/facility_prediction_result.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'facility_prediction_results.freezed.dart';
part 'facility_prediction_results.g.dart';

@freezed
class FacilityPredictionResults with _$FacilityPredictionResults {
  const factory FacilityPredictionResults({
    required List<FacilityPredictionResult> predictions,
  }) = _FacilityPredictionResults;

  factory FacilityPredictionResults.fromJson(Map<String, dynamic> json) => _$FacilityPredictionResultsFromJson(json);
}
