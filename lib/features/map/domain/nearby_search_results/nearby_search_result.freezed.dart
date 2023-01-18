// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'nearby_search_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

NearbySearchResult _$NearbySearchResultFromJson(Map<String, dynamic> json) {
  return _NearbySearchResult.fromJson(json);
}

/// @nodoc
mixin _$NearbySearchResult {
  Geometry get geometry => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'place_id')
  String get placeId => throw _privateConstructorUsedError;
  String get vicinity => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NearbySearchResultCopyWith<NearbySearchResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NearbySearchResultCopyWith<$Res> {
  factory $NearbySearchResultCopyWith(
          NearbySearchResult value, $Res Function(NearbySearchResult) then) =
      _$NearbySearchResultCopyWithImpl<$Res, NearbySearchResult>;
  @useResult
  $Res call(
      {Geometry geometry,
      String name,
      @JsonKey(name: 'place_id') String placeId,
      String vicinity});

  $GeometryCopyWith<$Res> get geometry;
}

/// @nodoc
class _$NearbySearchResultCopyWithImpl<$Res, $Val extends NearbySearchResult>
    implements $NearbySearchResultCopyWith<$Res> {
  _$NearbySearchResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? geometry = null,
    Object? name = null,
    Object? placeId = null,
    Object? vicinity = null,
  }) {
    return _then(_value.copyWith(
      geometry: null == geometry
          ? _value.geometry
          : geometry // ignore: cast_nullable_to_non_nullable
              as Geometry,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      placeId: null == placeId
          ? _value.placeId
          : placeId // ignore: cast_nullable_to_non_nullable
              as String,
      vicinity: null == vicinity
          ? _value.vicinity
          : vicinity // ignore: cast_nullable_to_non_nullable
              as String,
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
abstract class _$$_NearbySearchResultCopyWith<$Res>
    implements $NearbySearchResultCopyWith<$Res> {
  factory _$$_NearbySearchResultCopyWith(_$_NearbySearchResult value,
          $Res Function(_$_NearbySearchResult) then) =
      __$$_NearbySearchResultCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Geometry geometry,
      String name,
      @JsonKey(name: 'place_id') String placeId,
      String vicinity});

  @override
  $GeometryCopyWith<$Res> get geometry;
}

/// @nodoc
class __$$_NearbySearchResultCopyWithImpl<$Res>
    extends _$NearbySearchResultCopyWithImpl<$Res, _$_NearbySearchResult>
    implements _$$_NearbySearchResultCopyWith<$Res> {
  __$$_NearbySearchResultCopyWithImpl(
      _$_NearbySearchResult _value, $Res Function(_$_NearbySearchResult) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? geometry = null,
    Object? name = null,
    Object? placeId = null,
    Object? vicinity = null,
  }) {
    return _then(_$_NearbySearchResult(
      geometry: null == geometry
          ? _value.geometry
          : geometry // ignore: cast_nullable_to_non_nullable
              as Geometry,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      placeId: null == placeId
          ? _value.placeId
          : placeId // ignore: cast_nullable_to_non_nullable
              as String,
      vicinity: null == vicinity
          ? _value.vicinity
          : vicinity // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_NearbySearchResult extends _NearbySearchResult {
  const _$_NearbySearchResult(
      {required this.geometry,
      required this.name,
      @JsonKey(name: 'place_id') required this.placeId,
      required this.vicinity})
      : super._();

  factory _$_NearbySearchResult.fromJson(Map<String, dynamic> json) =>
      _$$_NearbySearchResultFromJson(json);

  @override
  final Geometry geometry;
  @override
  final String name;
  @override
  @JsonKey(name: 'place_id')
  final String placeId;
  @override
  final String vicinity;

  @override
  String toString() {
    return 'NearbySearchResult(geometry: $geometry, name: $name, placeId: $placeId, vicinity: $vicinity)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_NearbySearchResult &&
            (identical(other.geometry, geometry) ||
                other.geometry == geometry) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.placeId, placeId) || other.placeId == placeId) &&
            (identical(other.vicinity, vicinity) ||
                other.vicinity == vicinity));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, geometry, name, placeId, vicinity);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_NearbySearchResultCopyWith<_$_NearbySearchResult> get copyWith =>
      __$$_NearbySearchResultCopyWithImpl<_$_NearbySearchResult>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_NearbySearchResultToJson(
      this,
    );
  }
}

abstract class _NearbySearchResult extends NearbySearchResult {
  const factory _NearbySearchResult(
      {required final Geometry geometry,
      required final String name,
      @JsonKey(name: 'place_id') required final String placeId,
      required final String vicinity}) = _$_NearbySearchResult;
  const _NearbySearchResult._() : super._();

  factory _NearbySearchResult.fromJson(Map<String, dynamic> json) =
      _$_NearbySearchResult.fromJson;

  @override
  Geometry get geometry;
  @override
  String get name;
  @override
  @JsonKey(name: 'place_id')
  String get placeId;
  @override
  String get vicinity;
  @override
  @JsonKey(ignore: true)
  _$$_NearbySearchResultCopyWith<_$_NearbySearchResult> get copyWith =>
      throw _privateConstructorUsedError;
}
