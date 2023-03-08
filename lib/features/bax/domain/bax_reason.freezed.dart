// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bax_reason.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

BaxReason _$BaxReasonFromJson(Map<String, dynamic> json) {
  return _BaxReason.fromJson(json);
}

/// @nodoc
mixin _$BaxReason {
  /// 付与理由を日本語で明記
  ///
  /// - 新規施設投稿
  /// - bax投稿
  /// - 本日初投稿
  /// - etc...
  String get text => throw _privateConstructorUsedError;

  /// 付与ポイント
  double get point => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BaxReasonCopyWith<BaxReason> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BaxReasonCopyWith<$Res> {
  factory $BaxReasonCopyWith(BaxReason value, $Res Function(BaxReason) then) =
      _$BaxReasonCopyWithImpl<$Res, BaxReason>;
  @useResult
  $Res call({String text, double point});
}

/// @nodoc
class _$BaxReasonCopyWithImpl<$Res, $Val extends BaxReason>
    implements $BaxReasonCopyWith<$Res> {
  _$BaxReasonCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? point = null,
  }) {
    return _then(_value.copyWith(
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      point: null == point
          ? _value.point
          : point // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_BaxReasonCopyWith<$Res> implements $BaxReasonCopyWith<$Res> {
  factory _$$_BaxReasonCopyWith(
          _$_BaxReason value, $Res Function(_$_BaxReason) then) =
      __$$_BaxReasonCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String text, double point});
}

/// @nodoc
class __$$_BaxReasonCopyWithImpl<$Res>
    extends _$BaxReasonCopyWithImpl<$Res, _$_BaxReason>
    implements _$$_BaxReasonCopyWith<$Res> {
  __$$_BaxReasonCopyWithImpl(
      _$_BaxReason _value, $Res Function(_$_BaxReason) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? point = null,
  }) {
    return _then(_$_BaxReason(
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      point: null == point
          ? _value.point
          : point // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_BaxReason implements _BaxReason {
  const _$_BaxReason({this.text = '', this.point = 0.0});

  factory _$_BaxReason.fromJson(Map<String, dynamic> json) =>
      _$$_BaxReasonFromJson(json);

  /// 付与理由を日本語で明記
  ///
  /// - 新規施設投稿
  /// - bax投稿
  /// - 本日初投稿
  /// - etc...
  @override
  @JsonKey()
  final String text;

  /// 付与ポイント
  @override
  @JsonKey()
  final double point;

  @override
  String toString() {
    return 'BaxReason(text: $text, point: $point)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_BaxReason &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.point, point) || other.point == point));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, text, point);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_BaxReasonCopyWith<_$_BaxReason> get copyWith =>
      __$$_BaxReasonCopyWithImpl<_$_BaxReason>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BaxReasonToJson(
      this,
    );
  }
}

abstract class _BaxReason implements BaxReason {
  const factory _BaxReason({final String text, final double point}) =
      _$_BaxReason;

  factory _BaxReason.fromJson(Map<String, dynamic> json) =
      _$_BaxReason.fromJson;

  @override

  /// 付与理由を日本語で明記
  ///
  /// - 新規施設投稿
  /// - bax投稿
  /// - 本日初投稿
  /// - etc...
  String get text;
  @override

  /// 付与ポイント
  double get point;
  @override
  @JsonKey(ignore: true)
  _$$_BaxReasonCopyWith<_$_BaxReason> get copyWith =>
      throw _privateConstructorUsedError;
}
