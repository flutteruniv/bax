// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wifi_measurement_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_WifiMeasurementResult _$$_WifiMeasurementResultFromJson(Map<String, dynamic> json) => _$_WifiMeasurementResult(
      downloadSpeedMbps: (json['downloadSpeedMbps'] as num).toDouble(),
      uploadSpeedMbps: (json['uploadSpeedMbps'] as num).toDouble(),
      ssid: json['ssid'] as String,
    );

Map<String, dynamic> _$$_WifiMeasurementResultToJson(_$_WifiMeasurementResult instance) => <String, dynamic>{
      'downloadSpeedMbps': instance.downloadSpeedMbps,
      'uploadSpeedMbps': instance.uploadSpeedMbps,
      'ssid': instance.ssid,
    };
