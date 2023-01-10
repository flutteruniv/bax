
import 'package:freezed_annotation/freezed_annotation.dart';
part 'facility.freezed.dart';
part 'facility.g.dart';

@freezed
class Facility with _$Facility{
  const factory Facility ({

  ,}) = _Facility;

  /// 必要そうなもの
  /// - 施設の名前blank
  /// - 座標情報（緯度軽度）
  /// - 住所
  /// - ダウンロード速度
  /// - アップロード速度
  /// - 作成日
  /// - 更新日
  /// - 電源ある報告 int
  /// - 電源ない報告 int
  /// - 作業スペースある報告 int
  /// - 作業スペースない報告 int
  /// - 電源スポットの写真 List<String>
  /// - DocumentReference
  /// 
  /// GoogleMapAPIでの登録施設にIDがあればそれも付与したい
  /// 
  /// Wi-Fiの速度の3段階評価ロジック
  /// ダウンロード速度だけを判定する
  /// 0 < 30     100 < それ以上
  /// 
  /// collection名 facility でいこう

  factory Facility.fromJson(Map<String, dynamic> json) => _$FacilityFromJson(json);
}