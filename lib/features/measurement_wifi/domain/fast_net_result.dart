import 'package:bax/configs/converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'fast_net_result.freezed.dart';
part 'fast_net_result.g.dart';

@freezed
class FastNetResult with _$FastNetResult {
  const factory FastNetResult({
    @Default(0.0) @StringDoubleConverter() double downloadSpeedValue,
    @Default(0.0) @StringDoubleConverter() double uploadSpeedValue,

    /// latency ms
    @Default(0) @StringIntConverter() int latencyValue,

    /// ms
    @Default(0) @StringIntConverter() int bufferbloatValue,

    /// internet provider
    @Default('') String usrISP,
    @Default('') String downloadSpeedUnit,
    @Default('') String uploadSpeedUnit,
    @Default(false) bool isDone,
  }) = _FastNetResult;

  factory FastNetResult.fromJson(Map<String, dynamic> json) => _$FastNetResultFromJson(json);
}
