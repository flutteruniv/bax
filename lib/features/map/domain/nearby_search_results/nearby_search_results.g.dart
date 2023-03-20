// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nearby_search_results.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_NearbySearchResults _$$_NearbySearchResultsFromJson(
        Map<String, dynamic> json) =>
    _$_NearbySearchResults(
      results: (json['results'] as List<dynamic>)
          .map((e) => NearbySearchResult.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextPageToken: json['next_page_token'] as String?,
    );

Map<String, dynamic> _$$_NearbySearchResultsToJson(
        _$_NearbySearchResults instance) =>
    <String, dynamic>{
      'results': instance.results,
      'next_page_token': instance.nextPageToken,
    };
