// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'facility_prediction_results.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FacilityPredictionResults _$FacilityPredictionResultsFromJson(
    Map<String, dynamic> json) {
  return _FacilityPredictionResults.fromJson(json);
}

/// @nodoc
mixin _$FacilityPredictionResults {
  List<FacilityPredictionResult> get predictions =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FacilityPredictionResultsCopyWith<FacilityPredictionResults> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FacilityPredictionResultsCopyWith<$Res> {
  factory $FacilityPredictionResultsCopyWith(FacilityPredictionResults value,
          $Res Function(FacilityPredictionResults) then) =
      _$FacilityPredictionResultsCopyWithImpl<$Res, FacilityPredictionResults>;
  @useResult
  $Res call({List<FacilityPredictionResult> predictions});
}

/// @nodoc
class _$FacilityPredictionResultsCopyWithImpl<$Res,
        $Val extends FacilityPredictionResults>
    implements $FacilityPredictionResultsCopyWith<$Res> {
  _$FacilityPredictionResultsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? predictions = null,
  }) {
    return _then(_value.copyWith(
      predictions: null == predictions
          ? _value.predictions
          : predictions // ignore: cast_nullable_to_non_nullable
              as List<FacilityPredictionResult>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FacilityPredictionResultsCopyWith<$Res>
    implements $FacilityPredictionResultsCopyWith<$Res> {
  factory _$$_FacilityPredictionResultsCopyWith(
          _$_FacilityPredictionResults value,
          $Res Function(_$_FacilityPredictionResults) then) =
      __$$_FacilityPredictionResultsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<FacilityPredictionResult> predictions});
}

/// @nodoc
class __$$_FacilityPredictionResultsCopyWithImpl<$Res>
    extends _$FacilityPredictionResultsCopyWithImpl<$Res,
        _$_FacilityPredictionResults>
    implements _$$_FacilityPredictionResultsCopyWith<$Res> {
  __$$_FacilityPredictionResultsCopyWithImpl(
      _$_FacilityPredictionResults _value,
      $Res Function(_$_FacilityPredictionResults) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? predictions = null,
  }) {
    return _then(_$_FacilityPredictionResults(
      predictions: null == predictions
          ? _value._predictions
          : predictions // ignore: cast_nullable_to_non_nullable
              as List<FacilityPredictionResult>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_FacilityPredictionResults implements _FacilityPredictionResults {
  const _$_FacilityPredictionResults(
      {required final List<FacilityPredictionResult> predictions})
      : _predictions = predictions;

  factory _$_FacilityPredictionResults.fromJson(Map<String, dynamic> json) =>
      _$$_FacilityPredictionResultsFromJson(json);

  final List<FacilityPredictionResult> _predictions;
  @override
  List<FacilityPredictionResult> get predictions {
    if (_predictions is EqualUnmodifiableListView) return _predictions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_predictions);
  }

  @override
  String toString() {
    return 'FacilityPredictionResults(predictions: $predictions)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FacilityPredictionResults &&
            const DeepCollectionEquality()
                .equals(other._predictions, _predictions));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_predictions));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FacilityPredictionResultsCopyWith<_$_FacilityPredictionResults>
      get copyWith => __$$_FacilityPredictionResultsCopyWithImpl<
          _$_FacilityPredictionResults>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FacilityPredictionResultsToJson(
      this,
    );
  }
}

abstract class _FacilityPredictionResults implements FacilityPredictionResults {
  const factory _FacilityPredictionResults(
          {required final List<FacilityPredictionResult> predictions}) =
      _$_FacilityPredictionResults;

  factory _FacilityPredictionResults.fromJson(Map<String, dynamic> json) =
      _$_FacilityPredictionResults.fromJson;

  @override
  List<FacilityPredictionResult> get predictions;
  @override
  @JsonKey(ignore: true)
  _$$_FacilityPredictionResultsCopyWith<_$_FacilityPredictionResults>
      get copyWith => throw _privateConstructorUsedError;
}
