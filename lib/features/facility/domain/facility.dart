import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geoflutterfire_plus/geoflutterfire_plus.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../configs/converter.dart';
import '../../../configs/union_timestamp.dart';

part 'facility.freezed.dart';
part 'facility.g.dart';

@freezed
class Facility with _$Facility {
  const factory Facility({
    /// 施設Id
    required String id,

    /// 施設の名前
    required String name,

    /// geoHashを含んだ
    @GeoFirePointConverter() required GeoFirePoint geo,

    /// 住所
    required String address,

    /// ダウンロード速度
    required double downloadSpeed,

    /// アップロード速度
    required double uploadSpeed,

    /// 作成日
    @unionTimestampConverter @Default(UnionTimestamp.serverTimestamp()) UnionTimestamp createdAt,

    /// 更新日
    @alwaysUseServerTimestampUnionTimestampConverter
    @Default(UnionTimestamp.serverTimestamp())
        UnionTimestamp updatedAt,

    /// 電源あり報告
    ///
    /// 報告者のuidを追加する
    @Default(<String>[]) List<String> hasPowerSource,

    /// 電源なし報告
    ///
    /// 報告者のuidを追加する
    @Default(<String>[]) List<String> noPowerSource,

    /// 作業スペースあり報告
    ///
    /// 報告者のuidを追加する
    @Default(<String>[]) List<String> hasWorkSpace,

    /// 作業スペースなし報告
    ///
    /// 報告者のuidを追加する
    @Default(<String>[]) List<String> noWorkSpace,

    /// 電源スポットの写真
    @Default(<String>[]) List<String> powerSourceSpots,

    /// DocumentReference
    @DocumentReferenceConverter() required DocumentReference docRef,
  }) = _Facility;

  const Facility._();

  factory Facility.fromJson(Map<String, dynamic> json) => _$FacilityFromJson(json);

  // ダウンロード速度速度に応じて3段階評価
  double get markerColor {
    if (downloadSpeed < 30) {
      return BitmapDescriptor.hueRed;
    } else if (downloadSpeed < 100) {
      return BitmapDescriptor.hueGreen;
    } else {
      return BitmapDescriptor.hueBlue;
    }
  }
}
