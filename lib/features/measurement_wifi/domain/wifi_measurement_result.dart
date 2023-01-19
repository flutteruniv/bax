import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../configs/union_timestamp.dart';

part 'wifi_measurement_result.freezed.dart';
part 'wifi_measurement_result.g.dart';

@freezed
class WifiMeasurementResult with _$WifiMeasurementResult {
  const factory WifiMeasurementResult({
    /// 計測したWi-FiのSSID
    required String ssid,

    /// ダウンロード速度 単位はMbps
    required double downloadSpeedMbps,

    /// アップロード速度 単位はMbps
    required double uploadSpeedMbps,

    /// latency ms
    required int latencyValue,

    /// ms
    required int bufferbloatValue,

    /// internet provider
    @Default('') String usrISP,

    /// 作成日
    @unionTimestampConverter @Default(UnionTimestamp.serverTimestamp()) UnionTimestamp createdAt,

    /// GoogleMapのPlaceId
    required String placeId,

    /// 投稿したユーザーのID
    required String uid,
  }) = _WifiMeasurementResult;

  factory WifiMeasurementResult.fromJson(Map<String, dynamic> json) => _$WifiMeasurementResultFromJson(json);
}
