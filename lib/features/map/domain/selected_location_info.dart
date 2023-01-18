import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'selected_location_info.freezed.dart';

/// ユーザーが施設予測結果から選択したときに返すロケーション情報
@freezed
class SelectedLocationInfo with _$SelectedLocationInfo {
  const factory SelectedLocationInfo({
    /// 施設ID
    required String facilityId,

    /// 施設名
    required String name,

    /// 緯度経度
    required LatLng latLng,

    /// 測定結果があるか
    required bool hasMeasurementResult,
  }) = _SelectedLocationInfo;
}
