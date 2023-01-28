import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../configs/union_timestamp.dart';

part 'measurement_history.freezed.dart';
part 'measurement_history.g.dart';

/// Firestoreに保存しておく測定履歴
@freezed
class MeasurementHistory with _$MeasurementHistory {
  const factory MeasurementHistory({
    /// 施設Id
    required String placeId,

    /// 施設の名前
    required String facilityName,

    /// ダウンロード速度
    required double downloadSpeed,

    /// アップロード速度
    required double uploadSpeed,

    /// 作成日
    @unionTimestampConverter @Default(UnionTimestamp.serverTimestamp()) UnionTimestamp createdAt,
  }) = _MeasurementHistory;

  factory MeasurementHistory.fromJson(Map<String, dynamic> json) => _$MeasurementHistoryFromJson(json);
}
