// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'facility_prediction_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FacilityPredictionResult _$FacilityPredictionResultFromJson(
    Map<String, dynamic> json) {
  return _FacilityPredictionResult.fromJson(json);
}

/// @nodoc
mixin _$FacilityPredictionResult {
  /// 施設Id
  @JsonKey(name: 'place_id')
  String get placeId => throw _privateConstructorUsedError;

  /// 施設名と住所が分割されたクラス
  @JsonKey(name: 'structured_formatting')
  FacilityPredictionResultFormatting get resultFormatting =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FacilityPredictionResultCopyWith<FacilityPredictionResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FacilityPredictionResultCopyWith<$Res> {
  factory $FacilityPredictionResultCopyWith(FacilityPredictionResult value,
          $Res Function(FacilityPredictionResult) then) =
      _$FacilityPredictionResultCopyWithImpl<$Res, FacilityPredictionResult>;
  @useResult
  $Res call(
      {@JsonKey(name: 'place_id')
          String placeId,
      @JsonKey(name: 'structured_formatting')
          FacilityPredictionResultFormatting resultFormatting});

  $FacilityPredictionResultFormattingCopyWith<$Res> get resultFormatting;
}

/// @nodoc
class _$FacilityPredictionResultCopyWithImpl<$Res,
        $Val extends FacilityPredictionResult>
    implements $FacilityPredictionResultCopyWith<$Res> {
  _$FacilityPredictionResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? placeId = null,
    Object? resultFormatting = null,
  }) {
    return _then(_value.copyWith(
      placeId: null == placeId
          ? _value.placeId
          : placeId // ignore: cast_nullable_to_non_nullable
              as String,
      resultFormatting: null == resultFormatting
          ? _value.resultFormatting
          : resultFormatting // ignore: cast_nullable_to_non_nullable
              as FacilityPredictionResultFormatting,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $FacilityPredictionResultFormattingCopyWith<$Res> get resultFormatting {
    return $FacilityPredictionResultFormattingCopyWith<$Res>(
        _value.resultFormatting, (value) {
      return _then(_value.copyWith(resultFormatting: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_FacilityPredictionResultCopyWith<$Res>
    implements $FacilityPredictionResultCopyWith<$Res> {
  factory _$$_FacilityPredictionResultCopyWith(
          _$_FacilityPredictionResult value,
          $Res Function(_$_FacilityPredictionResult) then) =
      __$$_FacilityPredictionResultCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'place_id')
          String placeId,
      @JsonKey(name: 'structured_formatting')
          FacilityPredictionResultFormatting resultFormatting});

  @override
  $FacilityPredictionResultFormattingCopyWith<$Res> get resultFormatting;
}

/// @nodoc
class __$$_FacilityPredictionResultCopyWithImpl<$Res>
    extends _$FacilityPredictionResultCopyWithImpl<$Res,
        _$_FacilityPredictionResult>
    implements _$$_FacilityPredictionResultCopyWith<$Res> {
  __$$_FacilityPredictionResultCopyWithImpl(_$_FacilityPredictionResult _value,
      $Res Function(_$_FacilityPredictionResult) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? placeId = null,
    Object? resultFormatting = null,
  }) {
    return _then(_$_FacilityPredictionResult(
      placeId: null == placeId
          ? _value.placeId
          : placeId // ignore: cast_nullable_to_non_nullable
              as String,
      resultFormatting: null == resultFormatting
          ? _value.resultFormatting
          : resultFormatting // ignore: cast_nullable_to_non_nullable
              as FacilityPredictionResultFormatting,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_FacilityPredictionResult implements _FacilityPredictionResult {
  const _$_FacilityPredictionResult(
      {@JsonKey(name: 'place_id') required this.placeId,
      @JsonKey(name: 'structured_formatting') required this.resultFormatting});

  factory _$_FacilityPredictionResult.fromJson(Map<String, dynamic> json) =>
      _$$_FacilityPredictionResultFromJson(json);

  /// 施設Id
  @override
  @JsonKey(name: 'place_id')
  final String placeId;

  /// 施設名と住所が分割されたクラス
  @override
  @JsonKey(name: 'structured_formatting')
  final FacilityPredictionResultFormatting resultFormatting;

  @override
  String toString() {
    return 'FacilityPredictionResult(placeId: $placeId, resultFormatting: $resultFormatting)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FacilityPredictionResult &&
            (identical(other.placeId, placeId) || other.placeId == placeId) &&
            (identical(other.resultFormatting, resultFormatting) ||
                other.resultFormatting == resultFormatting));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, placeId, resultFormatting);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FacilityPredictionResultCopyWith<_$_FacilityPredictionResult>
      get copyWith => __$$_FacilityPredictionResultCopyWithImpl<
          _$_FacilityPredictionResult>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FacilityPredictionResultToJson(
      this,
    );
  }
}

abstract class _FacilityPredictionResult implements FacilityPredictionResult {
  const factory _FacilityPredictionResult(
      {@JsonKey(name: 'place_id')
          required final String placeId,
      @JsonKey(name: 'structured_formatting')
          required final FacilityPredictionResultFormatting
              resultFormatting}) = _$_FacilityPredictionResult;

  factory _FacilityPredictionResult.fromJson(Map<String, dynamic> json) =
      _$_FacilityPredictionResult.fromJson;

  @override

  /// 施設Id
  @JsonKey(name: 'place_id')
  String get placeId;
  @override

  /// 施設名と住所が分割されたクラス
  @JsonKey(name: 'structured_formatting')
  FacilityPredictionResultFormatting get resultFormatting;
  @override
  @JsonKey(ignore: true)
  _$$_FacilityPredictionResultCopyWith<_$_FacilityPredictionResult>
      get copyWith => throw _privateConstructorUsedError;
}

FacilityPredictionResultFormatting _$FacilityPredictionResultFormattingFromJson(
    Map<String, dynamic> json) {
  return _FacilityPredictionResultFormatting.fromJson(json);
}

/// @nodoc
mixin _$FacilityPredictionResultFormatting {
  /// 施設名
  @JsonKey(name: 'main_text')
  String get name => throw _privateConstructorUsedError;

  /// 住所
  @JsonKey(name: 'secondary_text')
  String get address => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FacilityPredictionResultFormattingCopyWith<
          FacilityPredictionResultFormatting>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FacilityPredictionResultFormattingCopyWith<$Res> {
  factory $FacilityPredictionResultFormattingCopyWith(
          FacilityPredictionResultFormatting value,
          $Res Function(FacilityPredictionResultFormatting) then) =
      _$FacilityPredictionResultFormattingCopyWithImpl<$Res,
          FacilityPredictionResultFormatting>;
  @useResult
  $Res call(
      {@JsonKey(name: 'main_text') String name,
      @JsonKey(name: 'secondary_text') String address});
}

/// @nodoc
class _$FacilityPredictionResultFormattingCopyWithImpl<$Res,
        $Val extends FacilityPredictionResultFormatting>
    implements $FacilityPredictionResultFormattingCopyWith<$Res> {
  _$FacilityPredictionResultFormattingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? address = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FacilityPredictionResultFormattingCopyWith<$Res>
    implements $FacilityPredictionResultFormattingCopyWith<$Res> {
  factory _$$_FacilityPredictionResultFormattingCopyWith(
          _$_FacilityPredictionResultFormatting value,
          $Res Function(_$_FacilityPredictionResultFormatting) then) =
      __$$_FacilityPredictionResultFormattingCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'main_text') String name,
      @JsonKey(name: 'secondary_text') String address});
}

/// @nodoc
class __$$_FacilityPredictionResultFormattingCopyWithImpl<$Res>
    extends _$FacilityPredictionResultFormattingCopyWithImpl<$Res,
        _$_FacilityPredictionResultFormatting>
    implements _$$_FacilityPredictionResultFormattingCopyWith<$Res> {
  __$$_FacilityPredictionResultFormattingCopyWithImpl(
      _$_FacilityPredictionResultFormatting _value,
      $Res Function(_$_FacilityPredictionResultFormatting) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? address = null,
  }) {
    return _then(_$_FacilityPredictionResultFormatting(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_FacilityPredictionResultFormatting
    implements _FacilityPredictionResultFormatting {
  const _$_FacilityPredictionResultFormatting(
      {@JsonKey(name: 'main_text') required this.name,
      @JsonKey(name: 'secondary_text') required this.address});

  factory _$_FacilityPredictionResultFormatting.fromJson(
          Map<String, dynamic> json) =>
      _$$_FacilityPredictionResultFormattingFromJson(json);

  /// 施設名
  @override
  @JsonKey(name: 'main_text')
  final String name;

  /// 住所
  @override
  @JsonKey(name: 'secondary_text')
  final String address;

  @override
  String toString() {
    return 'FacilityPredictionResultFormatting(name: $name, address: $address)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FacilityPredictionResultFormatting &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.address, address) || other.address == address));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, address);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FacilityPredictionResultFormattingCopyWith<
          _$_FacilityPredictionResultFormatting>
      get copyWith => __$$_FacilityPredictionResultFormattingCopyWithImpl<
          _$_FacilityPredictionResultFormatting>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FacilityPredictionResultFormattingToJson(
      this,
    );
  }
}

abstract class _FacilityPredictionResultFormatting
    implements FacilityPredictionResultFormatting {
  const factory _FacilityPredictionResultFormatting(
          {@JsonKey(name: 'main_text') required final String name,
          @JsonKey(name: 'secondary_text') required final String address}) =
      _$_FacilityPredictionResultFormatting;

  factory _FacilityPredictionResultFormatting.fromJson(
          Map<String, dynamic> json) =
      _$_FacilityPredictionResultFormatting.fromJson;

  @override

  /// 施設名
  @JsonKey(name: 'main_text')
  String get name;
  @override

  /// 住所
  @JsonKey(name: 'secondary_text')
  String get address;
  @override
  @JsonKey(ignore: true)
  _$$_FacilityPredictionResultFormattingCopyWith<
          _$_FacilityPredictionResultFormatting>
      get copyWith => throw _privateConstructorUsedError;
}
