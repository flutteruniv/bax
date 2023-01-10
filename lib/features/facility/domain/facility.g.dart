// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'facility.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Facility _$$_FacilityFromJson(Map<String, dynamic> json) => _$_Facility(
      id: json['id'] as String,
      name: json['name'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      address: json['address'] as String,
      downloadSpeed: json['downloadSpeed'],
      uploadSpeed: json['uploadSpeed'],
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      hasPowerSource: json['hasPowerSource'],
      noPowerSource: json['noPowerSource'],
      hasWorkSpace: json['hasWorkSpace'],
      noWorkSpace: json['noWorkSpace'],
      powerSourceSpots: (json['powerSourceSpots'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      docRef: json['docRef'],
    );

Map<String, dynamic> _$$_FacilityToJson(_$_Facility instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'address': instance.address,
      'downloadSpeed': instance.downloadSpeed,
      'uploadSpeed': instance.uploadSpeed,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'hasPowerSource': instance.hasPowerSource,
      'noPowerSource': instance.noPowerSource,
      'hasWorkSpace': instance.hasWorkSpace,
      'noWorkSpace': instance.noWorkSpace,
      'powerSourceSpots': instance.powerSourceSpots,
      'docRef': instance.docRef,
    };
