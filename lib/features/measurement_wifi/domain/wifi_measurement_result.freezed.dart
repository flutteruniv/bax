// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wifi_measurement_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

WifiMeasurementResult _$WifiMeasurementResultFromJson(Map<String, dynamic> json) {
  return _WifiMeasurementResult.fromJson(json);
}

/// @nodoc
mixin _$WifiMeasurementResult {
  double get downloadSpeedMbps => throw _privateConstructorUsedError;
  double get uploadSpeedMbps => throw _privateConstructorUsedError;
  String get ssid => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WifiMeasurementResultCopyWith<WifiMeasurementResult> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WifiMeasurementResultCopyWith<$Res> {
  factory $WifiMeasurementResultCopyWith(WifiMeasurementResult value, $Res Function(WifiMeasurementResult) then) =
      _$WifiMeasurementResultCopyWithImpl<$Res, WifiMeasurementResult>;
  @useResult
  $Res call({double downloadSpeedMbps, double uploadSpeedMbps, String ssid});
}

/// @nodoc
class _$WifiMeasurementResultCopyWithImpl<$Res, $Val extends WifiMeasurementResult>
    implements $WifiMeasurementResultCopyWith<$Res> {
  _$WifiMeasurementResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? downloadSpeedMbps = null,
    Object? uploadSpeedMbps = null,
    Object? ssid = null,
  }) {
    return _then(_value.copyWith(
      downloadSpeedMbps: null == downloadSpeedMbps
          ? _value.downloadSpeedMbps
          : downloadSpeedMbps // ignore: cast_nullable_to_non_nullable
              as double,
      uploadSpeedMbps: null == uploadSpeedMbps
          ? _value.uploadSpeedMbps
          : uploadSpeedMbps // ignore: cast_nullable_to_non_nullable
              as double,
      ssid: null == ssid
          ? _value.ssid
          : ssid // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_WifiMeasurementResultCopyWith<$Res> implements $WifiMeasurementResultCopyWith<$Res> {
  factory _$$_WifiMeasurementResultCopyWith(
          _$_WifiMeasurementResult value, $Res Function(_$_WifiMeasurementResult) then) =
      __$$_WifiMeasurementResultCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double downloadSpeedMbps, double uploadSpeedMbps, String ssid});
}

/// @nodoc
class __$$_WifiMeasurementResultCopyWithImpl<$Res>
    extends _$WifiMeasurementResultCopyWithImpl<$Res, _$_WifiMeasurementResult>
    implements _$$_WifiMeasurementResultCopyWith<$Res> {
  __$$_WifiMeasurementResultCopyWithImpl(_$_WifiMeasurementResult _value, $Res Function(_$_WifiMeasurementResult) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? downloadSpeedMbps = null,
    Object? uploadSpeedMbps = null,
    Object? ssid = null,
  }) {
    return _then(_$_WifiMeasurementResult(
      downloadSpeedMbps: null == downloadSpeedMbps
          ? _value.downloadSpeedMbps
          : downloadSpeedMbps // ignore: cast_nullable_to_non_nullable
              as double,
      uploadSpeedMbps: null == uploadSpeedMbps
          ? _value.uploadSpeedMbps
          : uploadSpeedMbps // ignore: cast_nullable_to_non_nullable
              as double,
      ssid: null == ssid
          ? _value.ssid
          : ssid // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_WifiMeasurementResult implements _WifiMeasurementResult {
  const _$_WifiMeasurementResult({required this.downloadSpeedMbps, required this.uploadSpeedMbps, required this.ssid});

  factory _$_WifiMeasurementResult.fromJson(Map<String, dynamic> json) => _$$_WifiMeasurementResultFromJson(json);

  @override
  final double downloadSpeedMbps;
  @override
  final double uploadSpeedMbps;
  @override
  final String ssid;

  @override
  String toString() {
    return 'WifiMeasurementResult(downloadSpeedMbps: $downloadSpeedMbps, uploadSpeedMbps: $uploadSpeedMbps, ssid: $ssid)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_WifiMeasurementResult &&
            (identical(other.downloadSpeedMbps, downloadSpeedMbps) || other.downloadSpeedMbps == downloadSpeedMbps) &&
            (identical(other.uploadSpeedMbps, uploadSpeedMbps) || other.uploadSpeedMbps == uploadSpeedMbps) &&
            (identical(other.ssid, ssid) || other.ssid == ssid));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, downloadSpeedMbps, uploadSpeedMbps, ssid);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_WifiMeasurementResultCopyWith<_$_WifiMeasurementResult> get copyWith =>
      __$$_WifiMeasurementResultCopyWithImpl<_$_WifiMeasurementResult>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WifiMeasurementResultToJson(
      this,
    );
  }
}

abstract class _WifiMeasurementResult implements WifiMeasurementResult {
  const factory _WifiMeasurementResult(
      {required final double downloadSpeedMbps,
      required final double uploadSpeedMbps,
      required final String ssid}) = _$_WifiMeasurementResult;

  factory _WifiMeasurementResult.fromJson(Map<String, dynamic> json) = _$_WifiMeasurementResult.fromJson;

  @override
  double get downloadSpeedMbps;
  @override
  double get uploadSpeedMbps;
  @override
  String get ssid;
  @override
  @JsonKey(ignore: true)
  _$$_WifiMeasurementResultCopyWith<_$_WifiMeasurementResult> get copyWith => throw _privateConstructorUsedError;
}
