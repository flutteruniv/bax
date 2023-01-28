// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'measurement_history.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MeasurementHistory _$MeasurementHistoryFromJson(Map<String, dynamic> json) {
  return _MeasurementHistory.fromJson(json);
}

/// @nodoc
mixin _$MeasurementHistory {
  /// 施設Id
  String get placeId => throw _privateConstructorUsedError;

  /// 施設の名前
  String get facilityName => throw _privateConstructorUsedError;

  /// ダウンロード速度
  double get downloadSpeed => throw _privateConstructorUsedError;

  /// アップロード速度
  double get uploadSpeed => throw _privateConstructorUsedError;

  /// 作成日
  @unionTimestampConverter
  UnionTimestamp get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MeasurementHistoryCopyWith<MeasurementHistory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MeasurementHistoryCopyWith<$Res> {
  factory $MeasurementHistoryCopyWith(
          MeasurementHistory value, $Res Function(MeasurementHistory) then) =
      _$MeasurementHistoryCopyWithImpl<$Res, MeasurementHistory>;
  @useResult
  $Res call(
      {String placeId,
      String facilityName,
      double downloadSpeed,
      double uploadSpeed,
      @unionTimestampConverter UnionTimestamp createdAt});

  $UnionTimestampCopyWith<$Res> get createdAt;
}

/// @nodoc
class _$MeasurementHistoryCopyWithImpl<$Res, $Val extends MeasurementHistory>
    implements $MeasurementHistoryCopyWith<$Res> {
  _$MeasurementHistoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? placeId = null,
    Object? facilityName = null,
    Object? downloadSpeed = null,
    Object? uploadSpeed = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      placeId: null == placeId
          ? _value.placeId
          : placeId // ignore: cast_nullable_to_non_nullable
              as String,
      facilityName: null == facilityName
          ? _value.facilityName
          : facilityName // ignore: cast_nullable_to_non_nullable
              as String,
      downloadSpeed: null == downloadSpeed
          ? _value.downloadSpeed
          : downloadSpeed // ignore: cast_nullable_to_non_nullable
              as double,
      uploadSpeed: null == uploadSpeed
          ? _value.uploadSpeed
          : uploadSpeed // ignore: cast_nullable_to_non_nullable
              as double,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as UnionTimestamp,
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
abstract class _$$_MeasurementHistoryCopyWith<$Res>
    implements $MeasurementHistoryCopyWith<$Res> {
  factory _$$_MeasurementHistoryCopyWith(_$_MeasurementHistory value,
          $Res Function(_$_MeasurementHistory) then) =
      __$$_MeasurementHistoryCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String placeId,
      String facilityName,
      double downloadSpeed,
      double uploadSpeed,
      @unionTimestampConverter UnionTimestamp createdAt});

  @override
  $UnionTimestampCopyWith<$Res> get createdAt;
}

/// @nodoc
class __$$_MeasurementHistoryCopyWithImpl<$Res>
    extends _$MeasurementHistoryCopyWithImpl<$Res, _$_MeasurementHistory>
    implements _$$_MeasurementHistoryCopyWith<$Res> {
  __$$_MeasurementHistoryCopyWithImpl(
      _$_MeasurementHistory _value, $Res Function(_$_MeasurementHistory) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? placeId = null,
    Object? facilityName = null,
    Object? downloadSpeed = null,
    Object? uploadSpeed = null,
    Object? createdAt = null,
  }) {
    return _then(_$_MeasurementHistory(
      placeId: null == placeId
          ? _value.placeId
          : placeId // ignore: cast_nullable_to_non_nullable
              as String,
      facilityName: null == facilityName
          ? _value.facilityName
          : facilityName // ignore: cast_nullable_to_non_nullable
              as String,
      downloadSpeed: null == downloadSpeed
          ? _value.downloadSpeed
          : downloadSpeed // ignore: cast_nullable_to_non_nullable
              as double,
      uploadSpeed: null == uploadSpeed
          ? _value.uploadSpeed
          : uploadSpeed // ignore: cast_nullable_to_non_nullable
              as double,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as UnionTimestamp,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MeasurementHistory implements _MeasurementHistory {
  const _$_MeasurementHistory(
      {required this.placeId,
      required this.facilityName,
      required this.downloadSpeed,
      required this.uploadSpeed,
      @unionTimestampConverter
          this.createdAt = const UnionTimestamp.serverTimestamp()});

  factory _$_MeasurementHistory.fromJson(Map<String, dynamic> json) =>
      _$$_MeasurementHistoryFromJson(json);

  /// 施設Id
  @override
  final String placeId;

  /// 施設の名前
  @override
  final String facilityName;

  /// ダウンロード速度
  @override
  final double downloadSpeed;

  /// アップロード速度
  @override
  final double uploadSpeed;

  /// 作成日
  @override
  @JsonKey()
  @unionTimestampConverter
  final UnionTimestamp createdAt;

  @override
  String toString() {
    return 'MeasurementHistory(placeId: $placeId, facilityName: $facilityName, downloadSpeed: $downloadSpeed, uploadSpeed: $uploadSpeed, createdAt: $createdAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MeasurementHistory &&
            (identical(other.placeId, placeId) || other.placeId == placeId) &&
            (identical(other.facilityName, facilityName) ||
                other.facilityName == facilityName) &&
            (identical(other.downloadSpeed, downloadSpeed) ||
                other.downloadSpeed == downloadSpeed) &&
            (identical(other.uploadSpeed, uploadSpeed) ||
                other.uploadSpeed == uploadSpeed) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, placeId, facilityName,
      downloadSpeed, uploadSpeed, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MeasurementHistoryCopyWith<_$_MeasurementHistory> get copyWith =>
      __$$_MeasurementHistoryCopyWithImpl<_$_MeasurementHistory>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MeasurementHistoryToJson(
      this,
    );
  }
}

abstract class _MeasurementHistory implements MeasurementHistory {
  const factory _MeasurementHistory(
          {required final String placeId,
          required final String facilityName,
          required final double downloadSpeed,
          required final double uploadSpeed,
          @unionTimestampConverter final UnionTimestamp createdAt}) =
      _$_MeasurementHistory;

  factory _MeasurementHistory.fromJson(Map<String, dynamic> json) =
      _$_MeasurementHistory.fromJson;

  @override

  /// 施設Id
  String get placeId;
  @override

  /// 施設の名前
  String get facilityName;
  @override

  /// ダウンロード速度
  double get downloadSpeed;
  @override

  /// アップロード速度
  double get uploadSpeed;
  @override

  /// 作成日
  @unionTimestampConverter
  UnionTimestamp get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$_MeasurementHistoryCopyWith<_$_MeasurementHistory> get copyWith =>
      throw _privateConstructorUsedError;
}
