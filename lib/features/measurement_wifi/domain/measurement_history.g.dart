// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'measurement_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MeasurementHistory _$$_MeasurementHistoryFromJson(
        Map<String, dynamic> json) =>
    _$_MeasurementHistory(
      placeId: json['placeId'] as String,
      facilityName: json['facilityName'] as String,
      downloadSpeed: (json['downloadSpeed'] as num).toDouble(),
      uploadSpeed: (json['uploadSpeed'] as num).toDouble(),
      createdAt: json['createdAt'] == null
          ? const UnionTimestamp.serverTimestamp()
          : unionTimestampConverter.fromJson(json['createdAt'] as Object),
    );

Map<String, dynamic> _$$_MeasurementHistoryToJson(
        _$_MeasurementHistory instance) =>
    <String, dynamic>{
      'placeId': instance.placeId,
      'facilityName': instance.facilityName,
      'downloadSpeed': instance.downloadSpeed,
      'uploadSpeed': instance.uploadSpeed,
      'createdAt': unionTimestampConverter.toJson(instance.createdAt),
    };
