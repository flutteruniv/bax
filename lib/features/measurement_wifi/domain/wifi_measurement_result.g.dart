// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wifi_measurement_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_WifiMeasurementResult _$$_WifiMeasurementResultFromJson(
        Map<String, dynamic> json) =>
    _$_WifiMeasurementResult(
      ssid: json['ssid'] as String,
      downloadSpeedMbps: (json['downloadSpeedMbps'] as num).toDouble(),
      uploadSpeedMbps: (json['uploadSpeedMbps'] as num).toDouble(),
      latencyValue: json['latencyValue'] as int,
      bufferbloatValue: json['bufferbloatValue'] as int,
      usrISP: json['usrISP'] as String? ?? '',
      terminalTime:
          unionTimestampConverter.fromJson(json['terminalTime'] as Object),
      createdAt: json['createdAt'] == null
          ? const UnionTimestamp.serverTimestamp()
          : unionTimestampConverter.fromJson(json['createdAt'] as Object),
      placeId: json['placeId'] as String,
      uid: json['uid'] as String,
    );

Map<String, dynamic> _$$_WifiMeasurementResultToJson(
        _$_WifiMeasurementResult instance) =>
    <String, dynamic>{
      'ssid': instance.ssid,
      'downloadSpeedMbps': instance.downloadSpeedMbps,
      'uploadSpeedMbps': instance.uploadSpeedMbps,
      'latencyValue': instance.latencyValue,
      'bufferbloatValue': instance.bufferbloatValue,
      'usrISP': instance.usrISP,
      'terminalTime': unionTimestampConverter.toJson(instance.terminalTime),
      'createdAt': unionTimestampConverter.toJson(instance.createdAt),
      'placeId': instance.placeId,
      'uid': instance.uid,
    };
