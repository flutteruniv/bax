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

  const FastNetResult._();

  double get downloadSpeedMbps {
    if (downloadSpeedUnit.isEmpty) {
      return 0;
    }

    if (downloadSpeedUnit == 'Mbps') {
      return downloadSpeedValue;
    }

    return downloadSpeedValue / 1000;
  }

  double get uploadSpeedMbps {
    if (uploadSpeedUnit.isEmpty) {
      return 0;
    }

    if (uploadSpeedUnit == 'Mbps') {
      return uploadSpeedValue;
    }

    return uploadSpeedValue / 1000;
  }
}
