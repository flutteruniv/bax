// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fast_net_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FastNetResult _$FastNetResultFromJson(Map<String, dynamic> json) {
  return _FastNetResult.fromJson(json);
}

/// @nodoc
mixin _$FastNetResult {
  @StringDoubleConverter()
  double get downloadSpeedValue => throw _privateConstructorUsedError;
  @StringDoubleConverter()
  double get uploadSpeedValue => throw _privateConstructorUsedError;

  /// latency ms
  @StringIntConverter()
  int get latencyValue => throw _privateConstructorUsedError;

  /// ms
  @StringIntConverter()
  int get bufferbloatValue => throw _privateConstructorUsedError;

  /// internet provider
  String get usrISP => throw _privateConstructorUsedError;
  String get downloadSpeedUnit => throw _privateConstructorUsedError;
  String get uploadSpeedUnit => throw _privateConstructorUsedError;
  bool get isDone => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FastNetResultCopyWith<FastNetResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FastNetResultCopyWith<$Res> {
  factory $FastNetResultCopyWith(
          FastNetResult value, $Res Function(FastNetResult) then) =
      _$FastNetResultCopyWithImpl<$Res, FastNetResult>;
  @useResult
  $Res call(
      {@StringDoubleConverter() double downloadSpeedValue,
      @StringDoubleConverter() double uploadSpeedValue,
      @StringIntConverter() int latencyValue,
      @StringIntConverter() int bufferbloatValue,
      String usrISP,
      String downloadSpeedUnit,
      String uploadSpeedUnit,
      bool isDone});
}

/// @nodoc
class _$FastNetResultCopyWithImpl<$Res, $Val extends FastNetResult>
    implements $FastNetResultCopyWith<$Res> {
  _$FastNetResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? downloadSpeedValue = null,
    Object? uploadSpeedValue = null,
    Object? latencyValue = null,
    Object? bufferbloatValue = null,
    Object? usrISP = null,
    Object? downloadSpeedUnit = null,
    Object? uploadSpeedUnit = null,
    Object? isDone = null,
  }) {
    return _then(_value.copyWith(
      downloadSpeedValue: null == downloadSpeedValue
          ? _value.downloadSpeedValue
          : downloadSpeedValue // ignore: cast_nullable_to_non_nullable
              as double,
      uploadSpeedValue: null == uploadSpeedValue
          ? _value.uploadSpeedValue
          : uploadSpeedValue // ignore: cast_nullable_to_non_nullable
              as double,
      latencyValue: null == latencyValue
          ? _value.latencyValue
          : latencyValue // ignore: cast_nullable_to_non_nullable
              as int,
      bufferbloatValue: null == bufferbloatValue
          ? _value.bufferbloatValue
          : bufferbloatValue // ignore: cast_nullable_to_non_nullable
              as int,
      usrISP: null == usrISP
          ? _value.usrISP
          : usrISP // ignore: cast_nullable_to_non_nullable
              as String,
      downloadSpeedUnit: null == downloadSpeedUnit
          ? _value.downloadSpeedUnit
          : downloadSpeedUnit // ignore: cast_nullable_to_non_nullable
              as String,
      uploadSpeedUnit: null == uploadSpeedUnit
          ? _value.uploadSpeedUnit
          : uploadSpeedUnit // ignore: cast_nullable_to_non_nullable
              as String,
      isDone: null == isDone
          ? _value.isDone
          : isDone // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FastNetResultCopyWith<$Res>
    implements $FastNetResultCopyWith<$Res> {
  factory _$$_FastNetResultCopyWith(
          _$_FastNetResult value, $Res Function(_$_FastNetResult) then) =
      __$$_FastNetResultCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@StringDoubleConverter() double downloadSpeedValue,
      @StringDoubleConverter() double uploadSpeedValue,
      @StringIntConverter() int latencyValue,
      @StringIntConverter() int bufferbloatValue,
      String usrISP,
      String downloadSpeedUnit,
      String uploadSpeedUnit,
      bool isDone});
}

/// @nodoc
class __$$_FastNetResultCopyWithImpl<$Res>
    extends _$FastNetResultCopyWithImpl<$Res, _$_FastNetResult>
    implements _$$_FastNetResultCopyWith<$Res> {
  __$$_FastNetResultCopyWithImpl(
      _$_FastNetResult _value, $Res Function(_$_FastNetResult) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? downloadSpeedValue = null,
    Object? uploadSpeedValue = null,
    Object? latencyValue = null,
    Object? bufferbloatValue = null,
    Object? usrISP = null,
    Object? downloadSpeedUnit = null,
    Object? uploadSpeedUnit = null,
    Object? isDone = null,
  }) {
    return _then(_$_FastNetResult(
      downloadSpeedValue: null == downloadSpeedValue
          ? _value.downloadSpeedValue
          : downloadSpeedValue // ignore: cast_nullable_to_non_nullable
              as double,
      uploadSpeedValue: null == uploadSpeedValue
          ? _value.uploadSpeedValue
          : uploadSpeedValue // ignore: cast_nullable_to_non_nullable
              as double,
      latencyValue: null == latencyValue
          ? _value.latencyValue
          : latencyValue // ignore: cast_nullable_to_non_nullable
              as int,
      bufferbloatValue: null == bufferbloatValue
          ? _value.bufferbloatValue
          : bufferbloatValue // ignore: cast_nullable_to_non_nullable
              as int,
      usrISP: null == usrISP
          ? _value.usrISP
          : usrISP // ignore: cast_nullable_to_non_nullable
              as String,
      downloadSpeedUnit: null == downloadSpeedUnit
          ? _value.downloadSpeedUnit
          : downloadSpeedUnit // ignore: cast_nullable_to_non_nullable
              as String,
      uploadSpeedUnit: null == uploadSpeedUnit
          ? _value.uploadSpeedUnit
          : uploadSpeedUnit // ignore: cast_nullable_to_non_nullable
              as String,
      isDone: null == isDone
          ? _value.isDone
          : isDone // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_FastNetResult extends _FastNetResult {
  const _$_FastNetResult(
      {@StringDoubleConverter() this.downloadSpeedValue = 0.0,
      @StringDoubleConverter() this.uploadSpeedValue = 0.0,
      @StringIntConverter() this.latencyValue = 0,
      @StringIntConverter() this.bufferbloatValue = 0,
      this.usrISP = '',
      this.downloadSpeedUnit = '',
      this.uploadSpeedUnit = '',
      this.isDone = false})
      : super._();

  factory _$_FastNetResult.fromJson(Map<String, dynamic> json) =>
      _$$_FastNetResultFromJson(json);

  @override
  @JsonKey()
  @StringDoubleConverter()
  final double downloadSpeedValue;
  @override
  @JsonKey()
  @StringDoubleConverter()
  final double uploadSpeedValue;

  /// latency ms
  @override
  @JsonKey()
  @StringIntConverter()
  final int latencyValue;

  /// ms
  @override
  @JsonKey()
  @StringIntConverter()
  final int bufferbloatValue;

  /// internet provider
  @override
  @JsonKey()
  final String usrISP;
  @override
  @JsonKey()
  final String downloadSpeedUnit;
  @override
  @JsonKey()
  final String uploadSpeedUnit;
  @override
  @JsonKey()
  final bool isDone;

  @override
  String toString() {
    return 'FastNetResult(downloadSpeedValue: $downloadSpeedValue, uploadSpeedValue: $uploadSpeedValue, latencyValue: $latencyValue, bufferbloatValue: $bufferbloatValue, usrISP: $usrISP, downloadSpeedUnit: $downloadSpeedUnit, uploadSpeedUnit: $uploadSpeedUnit, isDone: $isDone)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FastNetResult &&
            (identical(other.downloadSpeedValue, downloadSpeedValue) ||
                other.downloadSpeedValue == downloadSpeedValue) &&
            (identical(other.uploadSpeedValue, uploadSpeedValue) ||
                other.uploadSpeedValue == uploadSpeedValue) &&
            (identical(other.latencyValue, latencyValue) ||
                other.latencyValue == latencyValue) &&
            (identical(other.bufferbloatValue, bufferbloatValue) ||
                other.bufferbloatValue == bufferbloatValue) &&
            (identical(other.usrISP, usrISP) || other.usrISP == usrISP) &&
            (identical(other.downloadSpeedUnit, downloadSpeedUnit) ||
                other.downloadSpeedUnit == downloadSpeedUnit) &&
            (identical(other.uploadSpeedUnit, uploadSpeedUnit) ||
                other.uploadSpeedUnit == uploadSpeedUnit) &&
            (identical(other.isDone, isDone) || other.isDone == isDone));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      downloadSpeedValue,
      uploadSpeedValue,
      latencyValue,
      bufferbloatValue,
      usrISP,
      downloadSpeedUnit,
      uploadSpeedUnit,
      isDone);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FastNetResultCopyWith<_$_FastNetResult> get copyWith =>
      __$$_FastNetResultCopyWithImpl<_$_FastNetResult>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FastNetResultToJson(
      this,
    );
  }
}

abstract class _FastNetResult extends FastNetResult {
  const factory _FastNetResult(
      {@StringDoubleConverter() final double downloadSpeedValue,
      @StringDoubleConverter() final double uploadSpeedValue,
      @StringIntConverter() final int latencyValue,
      @StringIntConverter() final int bufferbloatValue,
      final String usrISP,
      final String downloadSpeedUnit,
      final String uploadSpeedUnit,
      final bool isDone}) = _$_FastNetResult;
  const _FastNetResult._() : super._();

  factory _FastNetResult.fromJson(Map<String, dynamic> json) =
      _$_FastNetResult.fromJson;

  @override
  @StringDoubleConverter()
  double get downloadSpeedValue;
  @override
  @StringDoubleConverter()
  double get uploadSpeedValue;
  @override

  /// latency ms
  @StringIntConverter()
  int get latencyValue;
  @override

  /// ms
  @StringIntConverter()
  int get bufferbloatValue;
  @override

  /// internet provider
  String get usrISP;
  @override
  String get downloadSpeedUnit;
  @override
  String get uploadSpeedUnit;
  @override
  bool get isDone;
  @override
  @JsonKey(ignore: true)
  _$$_FastNetResultCopyWith<_$_FastNetResult> get copyWith =>
      throw _privateConstructorUsedError;
}
