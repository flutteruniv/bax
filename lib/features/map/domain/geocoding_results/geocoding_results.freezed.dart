// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'geocoding_results.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GeocodingResults _$GeocodingResultsFromJson(Map<String, dynamic> json) {
  return _GeocodingResults.fromJson(json);
}

/// @nodoc
mixin _$GeocodingResults {
  List<GeocodingResult> get results => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GeocodingResultsCopyWith<GeocodingResults> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GeocodingResultsCopyWith<$Res> {
  factory $GeocodingResultsCopyWith(
          GeocodingResults value, $Res Function(GeocodingResults) then) =
      _$GeocodingResultsCopyWithImpl<$Res, GeocodingResults>;
  @useResult
  $Res call({List<GeocodingResult> results});
}

/// @nodoc
class _$GeocodingResultsCopyWithImpl<$Res, $Val extends GeocodingResults>
    implements $GeocodingResultsCopyWith<$Res> {
  _$GeocodingResultsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? results = null,
  }) {
    return _then(_value.copyWith(
      results: null == results
          ? _value.results
          : results // ignore: cast_nullable_to_non_nullable
              as List<GeocodingResult>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GeocodingResultsCopyWith<$Res>
    implements $GeocodingResultsCopyWith<$Res> {
  factory _$$_GeocodingResultsCopyWith(
          _$_GeocodingResults value, $Res Function(_$_GeocodingResults) then) =
      __$$_GeocodingResultsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<GeocodingResult> results});
}

/// @nodoc
class __$$_GeocodingResultsCopyWithImpl<$Res>
    extends _$GeocodingResultsCopyWithImpl<$Res, _$_GeocodingResults>
    implements _$$_GeocodingResultsCopyWith<$Res> {
  __$$_GeocodingResultsCopyWithImpl(
      _$_GeocodingResults _value, $Res Function(_$_GeocodingResults) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? results = null,
  }) {
    return _then(_$_GeocodingResults(
      results: null == results
          ? _value._results
          : results // ignore: cast_nullable_to_non_nullable
              as List<GeocodingResult>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GeocodingResults implements _GeocodingResults {
  const _$_GeocodingResults({required final List<GeocodingResult> results})
      : _results = results;

  factory _$_GeocodingResults.fromJson(Map<String, dynamic> json) =>
      _$$_GeocodingResultsFromJson(json);

  final List<GeocodingResult> _results;
  @override
  List<GeocodingResult> get results {
    if (_results is EqualUnmodifiableListView) return _results;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_results);
  }

  @override
  String toString() {
    return 'GeocodingResults(results: $results)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GeocodingResults &&
            const DeepCollectionEquality().equals(other._results, _results));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_results));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GeocodingResultsCopyWith<_$_GeocodingResults> get copyWith =>
      __$$_GeocodingResultsCopyWithImpl<_$_GeocodingResults>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GeocodingResultsToJson(
      this,
    );
  }
}

abstract class _GeocodingResults implements GeocodingResults {
  const factory _GeocodingResults(
      {required final List<GeocodingResult> results}) = _$_GeocodingResults;

  factory _GeocodingResults.fromJson(Map<String, dynamic> json) =
      _$_GeocodingResults.fromJson;

  @override
  List<GeocodingResult> get results;
  @override
  @JsonKey(ignore: true)
  _$$_GeocodingResultsCopyWith<_$_GeocodingResults> get copyWith =>
      throw _privateConstructorUsedError;
}
