// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fast_net_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_FastNetResult _$$_FastNetResultFromJson(Map<String, dynamic> json) =>
    _$_FastNetResult(
      downloadSpeedValue: json['downloadSpeedValue'] == null
          ? 0.0
          : const StringDoubleConverter()
              .fromJson(json['downloadSpeedValue'] as String),
      uploadSpeedValue: json['uploadSpeedValue'] == null
          ? 0.0
          : const StringDoubleConverter()
              .fromJson(json['uploadSpeedValue'] as String),
      latencyValue: json['latencyValue'] == null
          ? 0
          : const StringIntConverter().fromJson(json['latencyValue'] as String),
      bufferbloatValue: json['bufferbloatValue'] == null
          ? 0
          : const StringIntConverter()
              .fromJson(json['bufferbloatValue'] as String),
      usrISP: json['usrISP'] as String? ?? '',
      downloadSpeedUnit: json['downloadSpeedUnit'] as String? ?? '',
      uploadSpeedUnit: json['uploadSpeedUnit'] as String? ?? '',
      isDone: json['isDone'] as bool? ?? false,
    );

Map<String, dynamic> _$$_FastNetResultToJson(_$_FastNetResult instance) =>
    <String, dynamic>{
      'downloadSpeedValue':
          const StringDoubleConverter().toJson(instance.downloadSpeedValue),
      'uploadSpeedValue':
          const StringDoubleConverter().toJson(instance.uploadSpeedValue),
      'latencyValue': const StringIntConverter().toJson(instance.latencyValue),
      'bufferbloatValue':
          const StringIntConverter().toJson(instance.bufferbloatValue),
      'usrISP': instance.usrISP,
      'downloadSpeedUnit': instance.downloadSpeedUnit,
      'uploadSpeedUnit': instance.uploadSpeedUnit,
      'isDone': instance.isDone,
    };
