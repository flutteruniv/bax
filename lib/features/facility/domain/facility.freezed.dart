// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'facility.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Facility _$FacilityFromJson(Map<String, dynamic> json) {
  return _Facility.fromJson(json);
}

/// @nodoc
mixin _$Facility {
  /// 施設Id
  String get id => throw _privateConstructorUsedError;

  /// 施設の名前
  String get name => throw _privateConstructorUsedError;

  /// 緯度
  double get latitude => throw _privateConstructorUsedError;

  /// 軽度
  double get longitude => throw _privateConstructorUsedError;

  /// 住所
  String get address => throw _privateConstructorUsedError;

  /// ダウンロード速度
  Int get downloadSpeed => throw _privateConstructorUsedError;

  /// アップロード速度
  Int get uploadSpeed => throw _privateConstructorUsedError;

  /// 作成日
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// 更新日
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// 電源あり報告
  Int get hasPowerSource => throw _privateConstructorUsedError;

  /// 電源なし報告
  Int get noPowerSource => throw _privateConstructorUsedError;

  /// 作業スペースあり報告
  Int get hasWorkSpace => throw _privateConstructorUsedError;

  /// 作業スペースなし報告
  Int get noWorkSpace => throw _privateConstructorUsedError;

  /// 電源スポットの写真
  List<String> get powerSourceSpots => throw _privateConstructorUsedError;

  /// DocumentReference
  DocumentReference get docRef => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FacilityCopyWith<Facility> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FacilityCopyWith<$Res> {
  factory $FacilityCopyWith(Facility value, $Res Function(Facility) then) =
      _$FacilityCopyWithImpl<$Res, Facility>;
  @useResult
  $Res call(
      {String id,
      String name,
      double latitude,
      double longitude,
      String address,
      Int downloadSpeed,
      Int uploadSpeed,
      DateTime createdAt,
      DateTime updatedAt,
      Int hasPowerSource,
      Int noPowerSource,
      Int hasWorkSpace,
      Int noWorkSpace,
      List<String> powerSourceSpots,
      DocumentReference docRef});
}

/// @nodoc
class _$FacilityCopyWithImpl<$Res, $Val extends Facility>
    implements $FacilityCopyWith<$Res> {
  _$FacilityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? address = null,
    Object? downloadSpeed = freezed,
    Object? uploadSpeed = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? hasPowerSource = freezed,
    Object? noPowerSource = freezed,
    Object? hasWorkSpace = freezed,
    Object? noWorkSpace = freezed,
    Object? powerSourceSpots = null,
    Object? docRef = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      downloadSpeed: freezed == downloadSpeed
          ? _value.downloadSpeed
          : downloadSpeed // ignore: cast_nullable_to_non_nullable
              as Int,
      uploadSpeed: freezed == uploadSpeed
          ? _value.uploadSpeed
          : uploadSpeed // ignore: cast_nullable_to_non_nullable
              as Int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      hasPowerSource: freezed == hasPowerSource
          ? _value.hasPowerSource
          : hasPowerSource // ignore: cast_nullable_to_non_nullable
              as Int,
      noPowerSource: freezed == noPowerSource
          ? _value.noPowerSource
          : noPowerSource // ignore: cast_nullable_to_non_nullable
              as Int,
      hasWorkSpace: freezed == hasWorkSpace
          ? _value.hasWorkSpace
          : hasWorkSpace // ignore: cast_nullable_to_non_nullable
              as Int,
      noWorkSpace: freezed == noWorkSpace
          ? _value.noWorkSpace
          : noWorkSpace // ignore: cast_nullable_to_non_nullable
              as Int,
      powerSourceSpots: null == powerSourceSpots
          ? _value.powerSourceSpots
          : powerSourceSpots // ignore: cast_nullable_to_non_nullable
              as List<String>,
      docRef: freezed == docRef
          ? _value.docRef
          : docRef // ignore: cast_nullable_to_non_nullable
              as DocumentReference,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FacilityCopyWith<$Res> implements $FacilityCopyWith<$Res> {
  factory _$$_FacilityCopyWith(
          _$_Facility value, $Res Function(_$_Facility) then) =
      __$$_FacilityCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      double latitude,
      double longitude,
      String address,
      Int downloadSpeed,
      Int uploadSpeed,
      DateTime createdAt,
      DateTime updatedAt,
      Int hasPowerSource,
      Int noPowerSource,
      Int hasWorkSpace,
      Int noWorkSpace,
      List<String> powerSourceSpots,
      DocumentReference docRef});
}

/// @nodoc
class __$$_FacilityCopyWithImpl<$Res>
    extends _$FacilityCopyWithImpl<$Res, _$_Facility>
    implements _$$_FacilityCopyWith<$Res> {
  __$$_FacilityCopyWithImpl(
      _$_Facility _value, $Res Function(_$_Facility) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? address = null,
    Object? downloadSpeed = freezed,
    Object? uploadSpeed = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? hasPowerSource = freezed,
    Object? noPowerSource = freezed,
    Object? hasWorkSpace = freezed,
    Object? noWorkSpace = freezed,
    Object? powerSourceSpots = null,
    Object? docRef = freezed,
  }) {
    return _then(_$_Facility(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      downloadSpeed: freezed == downloadSpeed
          ? _value.downloadSpeed
          : downloadSpeed // ignore: cast_nullable_to_non_nullable
              as Int,
      uploadSpeed: freezed == uploadSpeed
          ? _value.uploadSpeed
          : uploadSpeed // ignore: cast_nullable_to_non_nullable
              as Int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      hasPowerSource: freezed == hasPowerSource
          ? _value.hasPowerSource
          : hasPowerSource // ignore: cast_nullable_to_non_nullable
              as Int,
      noPowerSource: freezed == noPowerSource
          ? _value.noPowerSource
          : noPowerSource // ignore: cast_nullable_to_non_nullable
              as Int,
      hasWorkSpace: freezed == hasWorkSpace
          ? _value.hasWorkSpace
          : hasWorkSpace // ignore: cast_nullable_to_non_nullable
              as Int,
      noWorkSpace: freezed == noWorkSpace
          ? _value.noWorkSpace
          : noWorkSpace // ignore: cast_nullable_to_non_nullable
              as Int,
      powerSourceSpots: null == powerSourceSpots
          ? _value._powerSourceSpots
          : powerSourceSpots // ignore: cast_nullable_to_non_nullable
              as List<String>,
      docRef: freezed == docRef
          ? _value.docRef
          : docRef // ignore: cast_nullable_to_non_nullable
              as DocumentReference,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Facility implements _Facility {
  const _$_Facility(
      {required this.id,
      required this.name,
      required this.latitude,
      required this.longitude,
      required this.address,
      required this.downloadSpeed,
      required this.uploadSpeed,
      required this.createdAt,
      required this.updatedAt,
      required this.hasPowerSource,
      required this.noPowerSource,
      required this.hasWorkSpace,
      required this.noWorkSpace,
      required final List<String> powerSourceSpots,
      required this.docRef})
      : _powerSourceSpots = powerSourceSpots;

  factory _$_Facility.fromJson(Map<String, dynamic> json) =>
      _$$_FacilityFromJson(json);

  /// 施設Id
  @override
  final String id;

  /// 施設の名前
  @override
  final String name;

  /// 緯度
  @override
  final double latitude;

  /// 軽度
  @override
  final double longitude;

  /// 住所
  @override
  final String address;

  /// ダウンロード速度
  @override
  final Int downloadSpeed;

  /// アップロード速度
  @override
  final Int uploadSpeed;

  /// 作成日
  @override
  final DateTime createdAt;

  /// 更新日
  @override
  final DateTime updatedAt;

  /// 電源あり報告
  @override
  final Int hasPowerSource;

  /// 電源なし報告
  @override
  final Int noPowerSource;

  /// 作業スペースあり報告
  @override
  final Int hasWorkSpace;

  /// 作業スペースなし報告
  @override
  final Int noWorkSpace;

  /// 電源スポットの写真
  final List<String> _powerSourceSpots;

  /// 電源スポットの写真
  @override
  List<String> get powerSourceSpots {
    if (_powerSourceSpots is EqualUnmodifiableListView)
      return _powerSourceSpots;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_powerSourceSpots);
  }

  /// DocumentReference
  @override
  final DocumentReference docRef;

  @override
  String toString() {
    return 'Facility(id: $id, name: $name, latitude: $latitude, longitude: $longitude, address: $address, downloadSpeed: $downloadSpeed, uploadSpeed: $uploadSpeed, createdAt: $createdAt, updatedAt: $updatedAt, hasPowerSource: $hasPowerSource, noPowerSource: $noPowerSource, hasWorkSpace: $hasWorkSpace, noWorkSpace: $noWorkSpace, powerSourceSpots: $powerSourceSpots, docRef: $docRef)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Facility &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.address, address) || other.address == address) &&
            const DeepCollectionEquality()
                .equals(other.downloadSpeed, downloadSpeed) &&
            const DeepCollectionEquality()
                .equals(other.uploadSpeed, uploadSpeed) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            const DeepCollectionEquality()
                .equals(other.hasPowerSource, hasPowerSource) &&
            const DeepCollectionEquality()
                .equals(other.noPowerSource, noPowerSource) &&
            const DeepCollectionEquality()
                .equals(other.hasWorkSpace, hasWorkSpace) &&
            const DeepCollectionEquality()
                .equals(other.noWorkSpace, noWorkSpace) &&
            const DeepCollectionEquality()
                .equals(other._powerSourceSpots, _powerSourceSpots) &&
            const DeepCollectionEquality().equals(other.docRef, docRef));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      latitude,
      longitude,
      address,
      const DeepCollectionEquality().hash(downloadSpeed),
      const DeepCollectionEquality().hash(uploadSpeed),
      createdAt,
      updatedAt,
      const DeepCollectionEquality().hash(hasPowerSource),
      const DeepCollectionEquality().hash(noPowerSource),
      const DeepCollectionEquality().hash(hasWorkSpace),
      const DeepCollectionEquality().hash(noWorkSpace),
      const DeepCollectionEquality().hash(_powerSourceSpots),
      const DeepCollectionEquality().hash(docRef));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FacilityCopyWith<_$_Facility> get copyWith =>
      __$$_FacilityCopyWithImpl<_$_Facility>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FacilityToJson(
      this,
    );
  }
}

abstract class _Facility implements Facility {
  const factory _Facility(
      {required final String id,
      required final String name,
      required final double latitude,
      required final double longitude,
      required final String address,
      required final Int downloadSpeed,
      required final Int uploadSpeed,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      required final Int hasPowerSource,
      required final Int noPowerSource,
      required final Int hasWorkSpace,
      required final Int noWorkSpace,
      required final List<String> powerSourceSpots,
      required final DocumentReference docRef}) = _$_Facility;

  factory _Facility.fromJson(Map<String, dynamic> json) = _$_Facility.fromJson;

  @override

  /// 施設Id
  String get id;
  @override

  /// 施設の名前
  String get name;
  @override

  /// 緯度
  double get latitude;
  @override

  /// 軽度
  double get longitude;
  @override

  /// 住所
  String get address;
  @override

  /// ダウンロード速度
  Int get downloadSpeed;
  @override

  /// アップロード速度
  Int get uploadSpeed;
  @override

  /// 作成日
  DateTime get createdAt;
  @override

  /// 更新日
  DateTime get updatedAt;
  @override

  /// 電源あり報告
  Int get hasPowerSource;
  @override

  /// 電源なし報告
  Int get noPowerSource;
  @override

  /// 作業スペースあり報告
  Int get hasWorkSpace;
  @override

  /// 作業スペースなし報告
  Int get noWorkSpace;
  @override

  /// 電源スポットの写真
  List<String> get powerSourceSpots;
  @override

  /// DocumentReference
  DocumentReference get docRef;
  @override
  @JsonKey(ignore: true)
  _$$_FacilityCopyWith<_$_Facility> get copyWith =>
      throw _privateConstructorUsedError;
}
