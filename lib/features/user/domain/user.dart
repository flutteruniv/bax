import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../configs/localizations.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    @Default(0.0) double baxPoint,
    @Default(false) bool isPro,
    LType? languageCode,
  }) = _User;

  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);
}
