import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../configs/union_timestamp.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    /// 作成日
    @unionTimestampConverter @Default(UnionTimestamp.serverTimestamp()) UnionTimestamp createdAt,

    /// FirebaseAuthのuid
    required String uid,

    /// BAXの合計値
    required double baxPoint,
  }) = _User;

  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);
}
