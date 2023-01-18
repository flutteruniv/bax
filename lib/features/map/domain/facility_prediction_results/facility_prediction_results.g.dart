// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'facility_prediction_results.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_FacilityPredictionResults _$$_FacilityPredictionResultsFromJson(
        Map<String, dynamic> json) =>
    _$_FacilityPredictionResults(
      predictions: (json['predictions'] as List<dynamic>)
          .map((e) =>
              FacilityPredictionResult.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_FacilityPredictionResultsToJson(
        _$_FacilityPredictionResults instance) =>
    <String, dynamic>{
      'predictions': instance.predictions,
    };
