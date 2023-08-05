// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'common_searched_facility.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CommonSearchedFacility _$CommonSearchedFacilityFromJson(
    Map<String, dynamic> json) {
  return _CommonSearchedFacility.fromJson(json);
}

/// @nodoc
mixin _$CommonSearchedFacility {
  String get placeId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CommonSearchedFacilityCopyWith<CommonSearchedFacility> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommonSearchedFacilityCopyWith<$Res> {
  factory $CommonSearchedFacilityCopyWith(CommonSearchedFacility value,
          $Res Function(CommonSearchedFacility) then) =
      _$CommonSearchedFacilityCopyWithImpl<$Res, CommonSearchedFacility>;
  @useResult
  $Res call({String placeId, String name, String address});
}

/// @nodoc
class _$CommonSearchedFacilityCopyWithImpl<$Res,
        $Val extends CommonSearchedFacility>
    implements $CommonSearchedFacilityCopyWith<$Res> {
  _$CommonSearchedFacilityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? placeId = null,
    Object? name = null,
    Object? address = null,
  }) {
    return _then(_value.copyWith(
      placeId: null == placeId
          ? _value.placeId
          : placeId // ignore: cast_nullable_to_non_nullable
              as String,
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
abstract class _$$_CommonSearchedFacilityCopyWith<$Res>
    implements $CommonSearchedFacilityCopyWith<$Res> {
  factory _$$_CommonSearchedFacilityCopyWith(_$_CommonSearchedFacility value,
          $Res Function(_$_CommonSearchedFacility) then) =
      __$$_CommonSearchedFacilityCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String placeId, String name, String address});
}

/// @nodoc
class __$$_CommonSearchedFacilityCopyWithImpl<$Res>
    extends _$CommonSearchedFacilityCopyWithImpl<$Res,
        _$_CommonSearchedFacility>
    implements _$$_CommonSearchedFacilityCopyWith<$Res> {
  __$$_CommonSearchedFacilityCopyWithImpl(_$_CommonSearchedFacility _value,
      $Res Function(_$_CommonSearchedFacility) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? placeId = null,
    Object? name = null,
    Object? address = null,
  }) {
    return _then(_$_CommonSearchedFacility(
      placeId: null == placeId
          ? _value.placeId
          : placeId // ignore: cast_nullable_to_non_nullable
              as String,
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
class _$_CommonSearchedFacility extends _CommonSearchedFacility {
  _$_CommonSearchedFacility(
      {required this.placeId, required this.name, required this.address})
      : super._();

  factory _$_CommonSearchedFacility.fromJson(Map<String, dynamic> json) =>
      _$$_CommonSearchedFacilityFromJson(json);

  @override
  final String placeId;
  @override
  final String name;
  @override
  final String address;

  @override
  String toString() {
    return 'CommonSearchedFacility(placeId: $placeId, name: $name, address: $address)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CommonSearchedFacility &&
            (identical(other.placeId, placeId) || other.placeId == placeId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.address, address) || other.address == address));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, placeId, name, address);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CommonSearchedFacilityCopyWith<_$_CommonSearchedFacility> get copyWith =>
      __$$_CommonSearchedFacilityCopyWithImpl<_$_CommonSearchedFacility>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CommonSearchedFacilityToJson(
      this,
    );
  }
}

abstract class _CommonSearchedFacility extends CommonSearchedFacility {
  factory _CommonSearchedFacility(
      {required final String placeId,
      required final String name,
      required final String address}) = _$_CommonSearchedFacility;
  _CommonSearchedFacility._() : super._();

  factory _CommonSearchedFacility.fromJson(Map<String, dynamic> json) =
      _$_CommonSearchedFacility.fromJson;

  @override
  String get placeId;
  @override
  String get name;
  @override
  String get address;
  @override
  @JsonKey(ignore: true)
  _$$_CommonSearchedFacilityCopyWith<_$_CommonSearchedFacility> get copyWith =>
      throw _privateConstructorUsedError;
}
