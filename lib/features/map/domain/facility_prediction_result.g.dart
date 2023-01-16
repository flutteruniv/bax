// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'facility_prediction_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_FacilityPredictionResult _$$_FacilityPredictionResultFromJson(
        Map<String, dynamic> json) =>
    _$_FacilityPredictionResult(
      placeId: json['place_id'] as String,
      resultFormatting: FacilityPredictionResultFormatting.fromJson(
          json['structured_formatting'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_FacilityPredictionResultToJson(
        _$_FacilityPredictionResult instance) =>
    <String, dynamic>{
      'place_id': instance.placeId,
      'structured_formatting': instance.resultFormatting,
    };

_$_FacilityPredictionResultFormatting
    _$$_FacilityPredictionResultFormattingFromJson(Map<String, dynamic> json) =>
        _$_FacilityPredictionResultFormatting(
          name: json['main_text'] as String,
          address: json['secondary_text'] as String,
        );

Map<String, dynamic> _$$_FacilityPredictionResultFormattingToJson(
        _$_FacilityPredictionResultFormatting instance) =>
    <String, dynamic>{
      'main_text': instance.name,
      'secondary_text': instance.address,
    };
