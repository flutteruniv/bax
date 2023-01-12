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
      downloadSpeed: json['downloadSpeed'] as int,
      uploadSpeed: json['uploadSpeed'] as int,
      createdAt: json['createdAt'] == null
          ? const UnionTimestamp.serverTimestamp()
          : unionTimestampConverter.fromJson(json['createdAt'] as Object),
      updatedAt: json['updatedAt'] == null
          ? const UnionTimestamp.serverTimestamp()
          : alwaysUseServerTimestampUnionTimestampConverter
              .fromJson(json['updatedAt'] as Object),
      hasPowerSource: json['hasPowerSource'] as int? ?? 0,
      noPowerSource: json['noPowerSource'] as int? ?? 0,
      hasWorkSpace: json['hasWorkSpace'] as int? ?? 0,
      noWorkSpace: json['noWorkSpace'] as int? ?? 0,
      powerSourceSpots: (json['powerSourceSpots'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      docRef: const DocumentReferenceConverter()
          .fromJson(json['docRef'] as DocumentReference<Object?>),
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
      'createdAt': unionTimestampConverter.toJson(instance.createdAt),
      'updatedAt': alwaysUseServerTimestampUnionTimestampConverter
          .toJson(instance.updatedAt),
      'hasPowerSource': instance.hasPowerSource,
      'noPowerSource': instance.noPowerSource,
      'hasWorkSpace': instance.hasWorkSpace,
      'noWorkSpace': instance.noWorkSpace,
      'powerSourceSpots': instance.powerSourceSpots,
      'docRef': const DocumentReferenceConverter().toJson(instance.docRef),
    };
