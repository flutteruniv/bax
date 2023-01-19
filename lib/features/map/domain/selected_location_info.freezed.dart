// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'selected_location_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SelectedLocationInfo {
  /// 施設ID
  String get facilityId => throw _privateConstructorUsedError;

  /// 施設名
  String get name => throw _privateConstructorUsedError;

  /// 緯度経度
  LatLng get latLng => throw _privateConstructorUsedError;

  /// 測定結果があるか
  bool get hasMeasurementResult => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SelectedLocationInfoCopyWith<SelectedLocationInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SelectedLocationInfoCopyWith<$Res> {
  factory $SelectedLocationInfoCopyWith(SelectedLocationInfo value,
          $Res Function(SelectedLocationInfo) then) =
      _$SelectedLocationInfoCopyWithImpl<$Res, SelectedLocationInfo>;
  @useResult
  $Res call(
      {String facilityId,
      String name,
      LatLng latLng,
      bool hasMeasurementResult});
}

/// @nodoc
class _$SelectedLocationInfoCopyWithImpl<$Res,
        $Val extends SelectedLocationInfo>
    implements $SelectedLocationInfoCopyWith<$Res> {
  _$SelectedLocationInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? facilityId = null,
    Object? name = null,
    Object? latLng = null,
    Object? hasMeasurementResult = null,
  }) {
    return _then(_value.copyWith(
      facilityId: null == facilityId
          ? _value.facilityId
          : facilityId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      latLng: null == latLng
          ? _value.latLng
          : latLng // ignore: cast_nullable_to_non_nullable
              as LatLng,
      hasMeasurementResult: null == hasMeasurementResult
          ? _value.hasMeasurementResult
          : hasMeasurementResult // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SelectedLocationInfoCopyWith<$Res>
    implements $SelectedLocationInfoCopyWith<$Res> {
  factory _$$_SelectedLocationInfoCopyWith(_$_SelectedLocationInfo value,
          $Res Function(_$_SelectedLocationInfo) then) =
      __$$_SelectedLocationInfoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String facilityId,
      String name,
      LatLng latLng,
      bool hasMeasurementResult});
}

/// @nodoc
class __$$_SelectedLocationInfoCopyWithImpl<$Res>
    extends _$SelectedLocationInfoCopyWithImpl<$Res, _$_SelectedLocationInfo>
    implements _$$_SelectedLocationInfoCopyWith<$Res> {
  __$$_SelectedLocationInfoCopyWithImpl(_$_SelectedLocationInfo _value,
      $Res Function(_$_SelectedLocationInfo) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? facilityId = null,
    Object? name = null,
    Object? latLng = null,
    Object? hasMeasurementResult = null,
  }) {
    return _then(_$_SelectedLocationInfo(
      facilityId: null == facilityId
          ? _value.facilityId
          : facilityId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      latLng: null == latLng
          ? _value.latLng
          : latLng // ignore: cast_nullable_to_non_nullable
              as LatLng,
      hasMeasurementResult: null == hasMeasurementResult
          ? _value.hasMeasurementResult
          : hasMeasurementResult // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_SelectedLocationInfo implements _SelectedLocationInfo {
  const _$_SelectedLocationInfo(
      {required this.facilityId,
      required this.name,
      required this.latLng,
      required this.hasMeasurementResult});

  /// 施設ID
  @override
  final String facilityId;

  /// 施設名
  @override
  final String name;

  /// 緯度経度
  @override
  final LatLng latLng;

  /// 測定結果があるか
  @override
  final bool hasMeasurementResult;

  @override
  String toString() {
    return 'SelectedLocationInfo(facilityId: $facilityId, name: $name, latLng: $latLng, hasMeasurementResult: $hasMeasurementResult)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SelectedLocationInfo &&
            (identical(other.facilityId, facilityId) ||
                other.facilityId == facilityId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.latLng, latLng) || other.latLng == latLng) &&
            (identical(other.hasMeasurementResult, hasMeasurementResult) ||
                other.hasMeasurementResult == hasMeasurementResult));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, facilityId, name, latLng, hasMeasurementResult);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SelectedLocationInfoCopyWith<_$_SelectedLocationInfo> get copyWith =>
      __$$_SelectedLocationInfoCopyWithImpl<_$_SelectedLocationInfo>(
          this, _$identity);
}

abstract class _SelectedLocationInfo implements SelectedLocationInfo {
  const factory _SelectedLocationInfo(
      {required final String facilityId,
      required final String name,
      required final LatLng latLng,
      required final bool hasMeasurementResult}) = _$_SelectedLocationInfo;

  @override

  /// 施設ID
  String get facilityId;
  @override

  /// 施設名
  String get name;
  @override

  /// 緯度経度
  LatLng get latLng;
  @override

  /// 測定結果があるか
  bool get hasMeasurementResult;
  @override
  @JsonKey(ignore: true)
  _$$_SelectedLocationInfoCopyWith<_$_SelectedLocationInfo> get copyWith =>
      throw _privateConstructorUsedError;
}
