import 'package:freezed_annotation/freezed_annotation.dart';

import 'nearby_search_result.dart';

part 'nearby_search_results.freezed.dart';
part 'nearby_search_results.g.dart';

@freezed
class NearbySearchResults with _$NearbySearchResults {
  const factory NearbySearchResults({
    required List<NearbySearchResult> results,
  }) = _NearbySearchResults;

  factory NearbySearchResults.fromJson(Map<String, dynamic> json) => _$NearbySearchResultsFromJson(json);
}
