// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nearby_search_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_NearbySearchResult _$$_NearbySearchResultFromJson(
        Map<String, dynamic> json) =>
    _$_NearbySearchResult(
      geometry: Geometry.fromJson(json['geometry'] as Map<String, dynamic>),
      name: json['name'] as String,
      types: (json['types'] as List<dynamic>).map((e) => e as String).toList(),
      placeId: json['place_id'] as String,
      vicinity: json['vicinity'] as String,
    );

Map<String, dynamic> _$$_NearbySearchResultToJson(
        _$_NearbySearchResult instance) =>
    <String, dynamic>{
      'geometry': instance.geometry,
      'name': instance.name,
      'types': instance.types,
      'place_id': instance.placeId,
      'vicinity': instance.vicinity,
    };
