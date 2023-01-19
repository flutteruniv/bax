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

WifiMeasurementResult _$WifiMeasurementResultFromJson(
    Map<String, dynamic> json) {
  return _WifiMeasurementResult.fromJson(json);
}

/// @nodoc
mixin _$WifiMeasurementResult {
  /// 計測したWi-FiのSSID
  String get ssid => throw _privateConstructorUsedError;

  /// ダウンロード速度 単位はMbps
  double get downloadSpeedMbps => throw _privateConstructorUsedError;

  /// アップロード速度 単位はMbps
  double get uploadSpeedMbps => throw _privateConstructorUsedError;

  /// latency ms
  int get latencyValue => throw _privateConstructorUsedError;

  /// ms
  int get bufferbloatValue => throw _privateConstructorUsedError;

  /// internet provider
  String get usrISP => throw _privateConstructorUsedError;

  /// 作成日
  @unionTimestampConverter
  UnionTimestamp get createdAt => throw _privateConstructorUsedError;

  /// GoogleMapのPlaceId
  String get placeId => throw _privateConstructorUsedError;

  /// 投稿したユーザーのID
  String get uid => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WifiMeasurementResultCopyWith<WifiMeasurementResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WifiMeasurementResultCopyWith<$Res> {
  factory $WifiMeasurementResultCopyWith(WifiMeasurementResult value,
          $Res Function(WifiMeasurementResult) then) =
      _$WifiMeasurementResultCopyWithImpl<$Res, WifiMeasurementResult>;
  @useResult
  $Res call(
      {String ssid,
      double downloadSpeedMbps,
      double uploadSpeedMbps,
      int latencyValue,
      int bufferbloatValue,
      String usrISP,
      @unionTimestampConverter UnionTimestamp createdAt,
      String placeId,
      String uid});

  $UnionTimestampCopyWith<$Res> get createdAt;
}

/// @nodoc
class _$WifiMeasurementResultCopyWithImpl<$Res,
        $Val extends WifiMeasurementResult>
    implements $WifiMeasurementResultCopyWith<$Res> {
  _$WifiMeasurementResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ssid = null,
    Object? downloadSpeedMbps = null,
    Object? uploadSpeedMbps = null,
    Object? latencyValue = null,
    Object? bufferbloatValue = null,
    Object? usrISP = null,
    Object? createdAt = null,
    Object? placeId = null,
    Object? uid = null,
  }) {
    return _then(_value.copyWith(
      ssid: null == ssid
          ? _value.ssid
          : ssid // ignore: cast_nullable_to_non_nullable
              as String,
      downloadSpeedMbps: null == downloadSpeedMbps
          ? _value.downloadSpeedMbps
          : downloadSpeedMbps // ignore: cast_nullable_to_non_nullable
              as double,
      uploadSpeedMbps: null == uploadSpeedMbps
          ? _value.uploadSpeedMbps
          : uploadSpeedMbps // ignore: cast_nullable_to_non_nullable
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
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as UnionTimestamp,
      placeId: null == placeId
          ? _value.placeId
          : placeId // ignore: cast_nullable_to_non_nullable
              as String,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UnionTimestampCopyWith<$Res> get createdAt {
    return $UnionTimestampCopyWith<$Res>(_value.createdAt, (value) {
      return _then(_value.copyWith(createdAt: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_WifiMeasurementResultCopyWith<$Res>
    implements $WifiMeasurementResultCopyWith<$Res> {
  factory _$$_WifiMeasurementResultCopyWith(_$_WifiMeasurementResult value,
          $Res Function(_$_WifiMeasurementResult) then) =
      __$$_WifiMeasurementResultCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String ssid,
      double downloadSpeedMbps,
      double uploadSpeedMbps,
      int latencyValue,
      int bufferbloatValue,
      String usrISP,
      @unionTimestampConverter UnionTimestamp createdAt,
      String placeId,
      String uid});

  @override
  $UnionTimestampCopyWith<$Res> get createdAt;
}

/// @nodoc
class __$$_WifiMeasurementResultCopyWithImpl<$Res>
    extends _$WifiMeasurementResultCopyWithImpl<$Res, _$_WifiMeasurementResult>
    implements _$$_WifiMeasurementResultCopyWith<$Res> {
  __$$_WifiMeasurementResultCopyWithImpl(_$_WifiMeasurementResult _value,
      $Res Function(_$_WifiMeasurementResult) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ssid = null,
    Object? downloadSpeedMbps = null,
    Object? uploadSpeedMbps = null,
    Object? latencyValue = null,
    Object? bufferbloatValue = null,
    Object? usrISP = null,
    Object? createdAt = null,
    Object? placeId = null,
    Object? uid = null,
  }) {
    return _then(_$_WifiMeasurementResult(
      ssid: null == ssid
          ? _value.ssid
          : ssid // ignore: cast_nullable_to_non_nullable
              as String,
      downloadSpeedMbps: null == downloadSpeedMbps
          ? _value.downloadSpeedMbps
          : downloadSpeedMbps // ignore: cast_nullable_to_non_nullable
              as double,
      uploadSpeedMbps: null == uploadSpeedMbps
          ? _value.uploadSpeedMbps
          : uploadSpeedMbps // ignore: cast_nullable_to_non_nullable
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
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as UnionTimestamp,
      placeId: null == placeId
          ? _value.placeId
          : placeId // ignore: cast_nullable_to_non_nullable
              as String,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_WifiMeasurementResult implements _WifiMeasurementResult {
  const _$_WifiMeasurementResult(
      {required this.ssid,
      required this.downloadSpeedMbps,
      required this.uploadSpeedMbps,
      required this.latencyValue,
      required this.bufferbloatValue,
      this.usrISP = '',
      @unionTimestampConverter
          this.createdAt = const UnionTimestamp.serverTimestamp(),
      required this.placeId,
      required this.uid});

  factory _$_WifiMeasurementResult.fromJson(Map<String, dynamic> json) =>
      _$$_WifiMeasurementResultFromJson(json);

  /// 計測したWi-FiのSSID
  @override
  final String ssid;

  /// ダウンロード速度 単位はMbps
  @override
  final double downloadSpeedMbps;

  /// アップロード速度 単位はMbps
  @override
  final double uploadSpeedMbps;

  /// latency ms
  @override
  final int latencyValue;

  /// ms
  @override
  final int bufferbloatValue;

  /// internet provider
  @override
  @JsonKey()
  final String usrISP;

  /// 作成日
  @override
  @JsonKey()
  @unionTimestampConverter
  final UnionTimestamp createdAt;

  /// GoogleMapのPlaceId
  @override
  final String placeId;

  /// 投稿したユーザーのID
  @override
  final String uid;

  @override
  String toString() {
    return 'WifiMeasurementResult(ssid: $ssid, downloadSpeedMbps: $downloadSpeedMbps, uploadSpeedMbps: $uploadSpeedMbps, latencyValue: $latencyValue, bufferbloatValue: $bufferbloatValue, usrISP: $usrISP, createdAt: $createdAt, placeId: $placeId, uid: $uid)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_WifiMeasurementResult &&
            (identical(other.ssid, ssid) || other.ssid == ssid) &&
            (identical(other.downloadSpeedMbps, downloadSpeedMbps) ||
                other.downloadSpeedMbps == downloadSpeedMbps) &&
            (identical(other.uploadSpeedMbps, uploadSpeedMbps) ||
                other.uploadSpeedMbps == uploadSpeedMbps) &&
            (identical(other.latencyValue, latencyValue) ||
                other.latencyValue == latencyValue) &&
            (identical(other.bufferbloatValue, bufferbloatValue) ||
                other.bufferbloatValue == bufferbloatValue) &&
            (identical(other.usrISP, usrISP) || other.usrISP == usrISP) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.placeId, placeId) || other.placeId == placeId) &&
            (identical(other.uid, uid) || other.uid == uid));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      ssid,
      downloadSpeedMbps,
      uploadSpeedMbps,
      latencyValue,
      bufferbloatValue,
      usrISP,
      createdAt,
      placeId,
      uid);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_WifiMeasurementResultCopyWith<_$_WifiMeasurementResult> get copyWith =>
      __$$_WifiMeasurementResultCopyWithImpl<_$_WifiMeasurementResult>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WifiMeasurementResultToJson(
      this,
    );
  }
}

abstract class _WifiMeasurementResult implements WifiMeasurementResult {
  const factory _WifiMeasurementResult(
      {required final String ssid,
      required final double downloadSpeedMbps,
      required final double uploadSpeedMbps,
      required final int latencyValue,
      required final int bufferbloatValue,
      final String usrISP,
      @unionTimestampConverter final UnionTimestamp createdAt,
      required final String placeId,
      required final String uid}) = _$_WifiMeasurementResult;

  factory _WifiMeasurementResult.fromJson(Map<String, dynamic> json) =
      _$_WifiMeasurementResult.fromJson;

  @override

  /// 計測したWi-FiのSSID
  String get ssid;
  @override

  /// ダウンロード速度 単位はMbps
  double get downloadSpeedMbps;
  @override

  /// アップロード速度 単位はMbps
  double get uploadSpeedMbps;
  @override

  /// latency ms
  int get latencyValue;
  @override

  /// ms
  int get bufferbloatValue;
  @override

  /// internet provider
  String get usrISP;
  @override

  /// 作成日
  @unionTimestampConverter
  UnionTimestamp get createdAt;
  @override

  /// GoogleMapのPlaceId
  String get placeId;
  @override

  /// 投稿したユーザーのID
  String get uid;
  @override
  @JsonKey(ignore: true)
  _$$_WifiMeasurementResultCopyWith<_$_WifiMeasurementResult> get copyWith =>
      throw _privateConstructorUsedError;
}
