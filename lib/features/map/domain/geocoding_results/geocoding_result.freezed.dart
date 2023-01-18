// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'geocoding_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GeocodingResult _$GeocodingResultFromJson(Map<String, dynamic> json) {
  return _GeocodingResult.fromJson(json);
}

/// @nodoc
mixin _$GeocodingResult {
  Geometry get geometry => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GeocodingResultCopyWith<GeocodingResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GeocodingResultCopyWith<$Res> {
  factory $GeocodingResultCopyWith(
          GeocodingResult value, $Res Function(GeocodingResult) then) =
      _$GeocodingResultCopyWithImpl<$Res, GeocodingResult>;
  @useResult
  $Res call({Geometry geometry});

  $GeometryCopyWith<$Res> get geometry;
}

/// @nodoc
class _$GeocodingResultCopyWithImpl<$Res, $Val extends GeocodingResult>
    implements $GeocodingResultCopyWith<$Res> {
  _$GeocodingResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? geometry = null,
  }) {
    return _then(_value.copyWith(
      geometry: null == geometry
          ? _value.geometry
          : geometry // ignore: cast_nullable_to_non_nullable
              as Geometry,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $GeometryCopyWith<$Res> get geometry {
    return $GeometryCopyWith<$Res>(_value.geometry, (value) {
      return _then(_value.copyWith(geometry: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_GeocodingResultCopyWith<$Res>
    implements $GeocodingResultCopyWith<$Res> {
  factory _$$_GeocodingResultCopyWith(
          _$_GeocodingResult value, $Res Function(_$_GeocodingResult) then) =
      __$$_GeocodingResultCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Geometry geometry});

  @override
  $GeometryCopyWith<$Res> get geometry;
}

/// @nodoc
class __$$_GeocodingResultCopyWithImpl<$Res>
    extends _$GeocodingResultCopyWithImpl<$Res, _$_GeocodingResult>
    implements _$$_GeocodingResultCopyWith<$Res> {
  __$$_GeocodingResultCopyWithImpl(
      _$_GeocodingResult _value, $Res Function(_$_GeocodingResult) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? geometry = null,
  }) {
    return _then(_$_GeocodingResult(
      geometry: null == geometry
          ? _value.geometry
          : geometry // ignore: cast_nullable_to_non_nullable
              as Geometry,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GeocodingResult implements _GeocodingResult {
  const _$_GeocodingResult({required this.geometry});

  factory _$_GeocodingResult.fromJson(Map<String, dynamic> json) =>
      _$$_GeocodingResultFromJson(json);

  @override
  final Geometry geometry;

  @override
  String toString() {
    return 'GeocodingResult(geometry: $geometry)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GeocodingResult &&
            (identical(other.geometry, geometry) ||
                other.geometry == geometry));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, geometry);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GeocodingResultCopyWith<_$_GeocodingResult> get copyWith =>
      __$$_GeocodingResultCopyWithImpl<_$_GeocodingResult>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GeocodingResultToJson(
      this,
    );
  }
}

abstract class _GeocodingResult implements GeocodingResult {
  const factory _GeocodingResult({required final Geometry geometry}) =
      _$_GeocodingResult;

  factory _GeocodingResult.fromJson(Map<String, dynamic> json) =
      _$_GeocodingResult.fromJson;

  @override
  Geometry get geometry;
  @override
  @JsonKey(ignore: true)
  _$$_GeocodingResultCopyWith<_$_GeocodingResult> get copyWith =>
      throw _privateConstructorUsedError;
}
