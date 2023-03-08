import 'package:freezed_annotation/freezed_annotation.dart';

part 'bax_reason.freezed.dart';
part 'bax_reason.g.dart';

@freezed
class BaxReason with _$BaxReason {
  const factory BaxReason({
    /// 付与理由を日本語で明記
    ///
    /// - 新規施設投稿
    /// - bax投稿
    /// - 本日初投稿
    /// - etc...
    @Default('') String text,

    /// 付与ポイント
    @Default(0.0) double point,
  }) = _BaxReason;

  factory BaxReason.fromJson(Map<String, dynamic> json) => _$BaxReasonFromJson(json);
}
