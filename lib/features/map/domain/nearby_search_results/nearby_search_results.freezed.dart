// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'nearby_search_results.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

NearbySearchResults _$NearbySearchResultsFromJson(Map<String, dynamic> json) {
  return _NearbySearchResults.fromJson(json);
}

/// @nodoc
mixin _$NearbySearchResults {
  List<NearbySearchResult> get results => throw _privateConstructorUsedError;
  @JsonKey(name: 'next_page_token')
  String? get nextPageToken => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NearbySearchResultsCopyWith<NearbySearchResults> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NearbySearchResultsCopyWith<$Res> {
  factory $NearbySearchResultsCopyWith(
          NearbySearchResults value, $Res Function(NearbySearchResults) then) =
      _$NearbySearchResultsCopyWithImpl<$Res, NearbySearchResults>;
  @useResult
  $Res call(
      {List<NearbySearchResult> results,
      @JsonKey(name: 'next_page_token') String? nextPageToken});
}

/// @nodoc
class _$NearbySearchResultsCopyWithImpl<$Res, $Val extends NearbySearchResults>
    implements $NearbySearchResultsCopyWith<$Res> {
  _$NearbySearchResultsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? results = null,
    Object? nextPageToken = freezed,
  }) {
    return _then(_value.copyWith(
      results: null == results
          ? _value.results
          : results // ignore: cast_nullable_to_non_nullable
              as List<NearbySearchResult>,
      nextPageToken: freezed == nextPageToken
          ? _value.nextPageToken
          : nextPageToken // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_NearbySearchResultsCopyWith<$Res>
    implements $NearbySearchResultsCopyWith<$Res> {
  factory _$$_NearbySearchResultsCopyWith(_$_NearbySearchResults value,
          $Res Function(_$_NearbySearchResults) then) =
      __$$_NearbySearchResultsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<NearbySearchResult> results,
      @JsonKey(name: 'next_page_token') String? nextPageToken});
}

/// @nodoc
class __$$_NearbySearchResultsCopyWithImpl<$Res>
    extends _$NearbySearchResultsCopyWithImpl<$Res, _$_NearbySearchResults>
    implements _$$_NearbySearchResultsCopyWith<$Res> {
  __$$_NearbySearchResultsCopyWithImpl(_$_NearbySearchResults _value,
      $Res Function(_$_NearbySearchResults) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? results = null,
    Object? nextPageToken = freezed,
  }) {
    return _then(_$_NearbySearchResults(
      results: null == results
          ? _value._results
          : results // ignore: cast_nullable_to_non_nullable
              as List<NearbySearchResult>,
      nextPageToken: freezed == nextPageToken
          ? _value.nextPageToken
          : nextPageToken // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_NearbySearchResults implements _NearbySearchResults {
  const _$_NearbySearchResults(
      {required final List<NearbySearchResult> results,
      @JsonKey(name: 'next_page_token') required this.nextPageToken})
      : _results = results;

  factory _$_NearbySearchResults.fromJson(Map<String, dynamic> json) =>
      _$$_NearbySearchResultsFromJson(json);

  final List<NearbySearchResult> _results;
  @override
  List<NearbySearchResult> get results {
    if (_results is EqualUnmodifiableListView) return _results;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_results);
  }

  @override
  @JsonKey(name: 'next_page_token')
  final String? nextPageToken;

  @override
  String toString() {
    return 'NearbySearchResults(results: $results, nextPageToken: $nextPageToken)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_NearbySearchResults &&
            const DeepCollectionEquality().equals(other._results, _results) &&
            (identical(other.nextPageToken, nextPageToken) ||
                other.nextPageToken == nextPageToken));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_results), nextPageToken);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_NearbySearchResultsCopyWith<_$_NearbySearchResults> get copyWith =>
      __$$_NearbySearchResultsCopyWithImpl<_$_NearbySearchResults>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_NearbySearchResultsToJson(
      this,
    );
  }
}

abstract class _NearbySearchResults implements NearbySearchResults {
  const factory _NearbySearchResults(
      {required final List<NearbySearchResult> results,
      @JsonKey(name: 'next_page_token')
          required final String? nextPageToken}) = _$_NearbySearchResults;

  factory _NearbySearchResults.fromJson(Map<String, dynamic> json) =
      _$_NearbySearchResults.fromJson;

  @override
  List<NearbySearchResult> get results;
  @override
  @JsonKey(name: 'next_page_token')
  String? get nextPageToken;
  @override
  @JsonKey(ignore: true)
  _$$_NearbySearchResultsCopyWith<_$_NearbySearchResults> get copyWith =>
      throw _privateConstructorUsedError;
}
