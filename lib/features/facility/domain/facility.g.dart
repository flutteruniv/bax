// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'facility.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Facility _$$_FacilityFromJson(Map<String, dynamic> json) => _$_Facility(
      id: json['id'] as String,
      name: json['name'] as String,
      geo: const GeoFirePointConverter()
          .fromJson(json['geo'] as Map<String, dynamic>),
      address: json['address'] as String,
      downloadSpeed: (json['downloadSpeed'] as num).toDouble(),
      uploadSpeed: (json['uploadSpeed'] as num).toDouble(),
      createdAt: json['createdAt'] == null
          ? const UnionTimestamp.serverTimestamp()
          : unionTimestampConverter.fromJson(json['createdAt'] as Object),
      updatedAt: json['updatedAt'] == null
          ? const UnionTimestamp.serverTimestamp()
          : alwaysUseServerTimestampUnionTimestampConverter
              .fromJson(json['updatedAt'] as Object),
      hasPowerSource: (json['hasPowerSource'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      noPowerSource: (json['noPowerSource'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      hasWorkSpace: (json['hasWorkSpace'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      noWorkSpace: (json['noWorkSpace'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
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
      'geo': const GeoFirePointConverter().toJson(instance.geo),
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
