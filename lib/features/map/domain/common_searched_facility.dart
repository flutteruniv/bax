import 'package:freezed_annotation/freezed_annotation.dart';

part 'common_searched_facility.freezed.dart';
part 'common_searched_facility.g.dart';

@freezed
class CommonSearchedFacility with _$CommonSearchedFacility {
  factory CommonSearchedFacility({
    required String placeId,
    required String name,
    required String address,
  }) = _CommonSearchedFacility;
  const CommonSearchedFacility._();

  factory CommonSearchedFacility.fromJson(Map<String, dynamic> json) => _$CommonSearchedFacilityFromJson(json);
}
