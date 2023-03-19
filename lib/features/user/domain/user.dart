import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../configs/union_timestamp.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    /// BAXの合計値
    required double baxPoint,
  }) = _User;

  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);
}
