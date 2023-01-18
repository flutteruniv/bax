// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geocoding_results.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GeocodingResults _$$_GeocodingResultsFromJson(Map<String, dynamic> json) =>
    _$_GeocodingResults(
      results: (json['results'] as List<dynamic>)
          .map((e) => GeocodingResult.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_GeocodingResultsToJson(_$_GeocodingResults instance) =>
    <String, dynamic>{
      'results': instance.results,
    };
