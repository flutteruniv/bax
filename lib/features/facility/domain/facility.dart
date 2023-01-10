import 'package:bax/configs/converter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'facility.freezed.dart';
part 'facility.g.dart';

@freezed
class Facility with _$Facility {
  const factory Facility({
    /// 施設Id
    required String id,

    /// 施設の名前
    required String name,

    /// 緯度
    required double latitude,

    /// 軽度
    required double longitude,

    /// 住所
    required String address,

    /// ダウンロード速度
    required int downloadSpeed,

    /// アップロード速度
    required int uploadSpeed,

    /// 作成日
    @TimestampConverter() required DateTime createdAt,

    /// 更新日
    @TimestampConverter() required DateTime updatedAt,

    /// 電源あり報告
    @Default(0) int hasPowerSource,

    /// 電源なし報告
    @Default(0) int noPowerSource,

    /// 作業スペースあり報告
    @Default(0) int hasWorkSpace,

    /// 作業スペースなし報告
    @Default(0) int noWorkSpace,

    /// 電源スポットの写真
    @Default(<String>[]) List<String> powerSourceSpots,

    /// DocumentReference
    @DocumentReferenceConverter() required DocumentReference docRef,
  }) = _Facility;

  ///
  /// Wi-Fiの速度の3段階評価ロジック
  /// ダウンロード速度だけを判定する
  /// 0 < 30     100 < それ以上
  ///
  /// collection名 facility でいこう

  factory Facility.fromJson(Map<String, dynamic> json) => _$FacilityFromJson(json);
}
