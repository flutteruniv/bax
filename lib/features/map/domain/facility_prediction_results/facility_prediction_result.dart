import 'package:freezed_annotation/freezed_annotation.dart';

part 'facility_prediction_result.freezed.dart';
part 'facility_prediction_result.g.dart';

@freezed
class FacilityPredictionResult with _$FacilityPredictionResult {
  const factory FacilityPredictionResult({
    /// 施設Id
    @JsonKey(name: 'place_id') required String placeId,

    /// 施設名と住所が分割されたクラス
    @JsonKey(name: 'structured_formatting') required FacilityPredictionResultFormatting resultFormatting,
  }) = _FacilityPredictionResult;

  factory FacilityPredictionResult.fromJson(Map<String, dynamic> json) => _$FacilityPredictionResultFromJson(json);
}

@freezed
class FacilityPredictionResultFormatting with _$FacilityPredictionResultFormatting {
  const factory FacilityPredictionResultFormatting({
    /// 施設名
    @JsonKey(name: 'main_text') required String name,

    /// 住所
    @JsonKey(name: 'secondary_text') required String address,
  }) = _FacilityPredictionResultFormatting;

  factory FacilityPredictionResultFormatting.fromJson(Map<String, dynamic> json) =>
      _$FacilityPredictionResultFormattingFromJson(json);
}
