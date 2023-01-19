import 'package:freezed_annotation/freezed_annotation.dart';

import '../geometry/geometry.dart';

part 'nearby_search_result.freezed.dart';
part 'nearby_search_result.g.dart';

@freezed
class NearbySearchResult with _$NearbySearchResult {
  const factory NearbySearchResult({
    required Geometry geometry,
    required String name,
    required List<String> types,
    @JsonKey(name: 'place_id') required String placeId,
    required String vicinity,
  }) = _NearbySearchResult;
  const NearbySearchResult._();
  factory NearbySearchResult.fromJson(Map<String, dynamic> json) => _$NearbySearchResultFromJson(json);
}
