import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../configs/union_timestamp.dart';
import 'bax_reason.dart';

part 'bax.freezed.dart';
part 'bax.g.dart';

@freezed
class Bax with _$Bax {
  @JsonSerializable(explicitToJson: true)
  const factory Bax({
    /// 作成日
    @unionTimestampConverter @Default(UnionTimestamp.serverTimestamp()) UnionTimestamp createdAt,

    /// FirebaseAuthのuid
    required String uid,

    /// ボーナス倍率
    ///
    /// キャンペーン等で1.2倍bax付与などを実装するために必要
    @Default(1.0) double bonusRate,

    /// 付与理由のリスト
    ///
    /// ユーザーにポイントを付与する場合には
    ///
    /// このリストのpoint値の合計に bonusRate を掛け合わせた値を付与する必要あり
    @Default(<BaxReason>[]) List<BaxReason> baxReasons,
  }) = _Bax;
  const Bax._();

  factory Bax.fromJson(Map<String, dynamic> json) => _$BaxFromJson(json);
}
