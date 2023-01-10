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
  int get downloadSpeed => throw _privateConstructorUsedError;

  /// アップロード速度
  int get uploadSpeed => throw _privateConstructorUsedError;

  /// 作成日
  @TimestampConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// 更新日
  @TimestampConverter()
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// 電源あり報告
  int get hasPowerSource => throw _privateConstructorUsedError;

  /// 電源なし報告
  int get noPowerSource => throw _privateConstructorUsedError;

  /// 作業スペースあり報告
  int get hasWorkSpace => throw _privateConstructorUsedError;

  /// 作業スペースなし報告
  int get noWorkSpace => throw _privateConstructorUsedError;

  /// 電源スポットの写真
  List<String> get powerSourceSpots => throw _privateConstructorUsedError;

  /// DocumentReference
  @DocumentReferenceConverter()
  DocumentReference<Object?> get docRef => throw _privateConstructorUsedError;

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
      int downloadSpeed,
      int uploadSpeed,
      @TimestampConverter() DateTime createdAt,
      @TimestampConverter() DateTime updatedAt,
      int hasPowerSource,
      int noPowerSource,
      int hasWorkSpace,
      int noWorkSpace,
      List<String> powerSourceSpots,
      @DocumentReferenceConverter() DocumentReference<Object?> docRef});
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
    Object? downloadSpeed = null,
    Object? uploadSpeed = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? hasPowerSource = null,
    Object? noPowerSource = null,
    Object? hasWorkSpace = null,
    Object? noWorkSpace = null,
    Object? powerSourceSpots = null,
    Object? docRef = null,
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
      downloadSpeed: null == downloadSpeed
          ? _value.downloadSpeed
          : downloadSpeed // ignore: cast_nullable_to_non_nullable
              as int,
      uploadSpeed: null == uploadSpeed
          ? _value.uploadSpeed
          : uploadSpeed // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      hasPowerSource: null == hasPowerSource
          ? _value.hasPowerSource
          : hasPowerSource // ignore: cast_nullable_to_non_nullable
              as int,
      noPowerSource: null == noPowerSource
          ? _value.noPowerSource
          : noPowerSource // ignore: cast_nullable_to_non_nullable
              as int,
      hasWorkSpace: null == hasWorkSpace
          ? _value.hasWorkSpace
          : hasWorkSpace // ignore: cast_nullable_to_non_nullable
              as int,
      noWorkSpace: null == noWorkSpace
          ? _value.noWorkSpace
          : noWorkSpace // ignore: cast_nullable_to_non_nullable
              as int,
      powerSourceSpots: null == powerSourceSpots
          ? _value.powerSourceSpots
          : powerSourceSpots // ignore: cast_nullable_to_non_nullable
              as List<String>,
      docRef: null == docRef
          ? _value.docRef
          : docRef // ignore: cast_nullable_to_non_nullable
              as DocumentReference<Object?>,
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
      int downloadSpeed,
      int uploadSpeed,
      @TimestampConverter() DateTime createdAt,
      @TimestampConverter() DateTime updatedAt,
      int hasPowerSource,
      int noPowerSource,
      int hasWorkSpace,
      int noWorkSpace,
      List<String> powerSourceSpots,
      @DocumentReferenceConverter() DocumentReference<Object?> docRef});
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
    Object? downloadSpeed = null,
    Object? uploadSpeed = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? hasPowerSource = null,
    Object? noPowerSource = null,
    Object? hasWorkSpace = null,
    Object? noWorkSpace = null,
    Object? powerSourceSpots = null,
    Object? docRef = null,
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
      downloadSpeed: null == downloadSpeed
          ? _value.downloadSpeed
          : downloadSpeed // ignore: cast_nullable_to_non_nullable
              as int,
      uploadSpeed: null == uploadSpeed
          ? _value.uploadSpeed
          : uploadSpeed // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      hasPowerSource: null == hasPowerSource
          ? _value.hasPowerSource
          : hasPowerSource // ignore: cast_nullable_to_non_nullable
              as int,
      noPowerSource: null == noPowerSource
          ? _value.noPowerSource
          : noPowerSource // ignore: cast_nullable_to_non_nullable
              as int,
      hasWorkSpace: null == hasWorkSpace
          ? _value.hasWorkSpace
          : hasWorkSpace // ignore: cast_nullable_to_non_nullable
              as int,
      noWorkSpace: null == noWorkSpace
          ? _value.noWorkSpace
          : noWorkSpace // ignore: cast_nullable_to_non_nullable
              as int,
      powerSourceSpots: null == powerSourceSpots
          ? _value._powerSourceSpots
          : powerSourceSpots // ignore: cast_nullable_to_non_nullable
              as List<String>,
      docRef: null == docRef
          ? _value.docRef
          : docRef // ignore: cast_nullable_to_non_nullable
              as DocumentReference<Object?>,
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
      @TimestampConverter() required this.createdAt,
      @TimestampConverter() required this.updatedAt,
      this.hasPowerSource = 0,
      this.noPowerSource = 0,
      this.hasWorkSpace = 0,
      this.noWorkSpace = 0,
      final List<String> powerSourceSpots = const <String>[],
      @DocumentReferenceConverter() required this.docRef})
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
  final int downloadSpeed;

  /// アップロード速度
  @override
  final int uploadSpeed;

  /// 作成日
  @override
  @TimestampConverter()
  final DateTime createdAt;

  /// 更新日
  @override
  @TimestampConverter()
  final DateTime updatedAt;

  /// 電源あり報告
  @override
  @JsonKey()
  final int hasPowerSource;

  /// 電源なし報告
  @override
  @JsonKey()
  final int noPowerSource;

  /// 作業スペースあり報告
  @override
  @JsonKey()
  final int hasWorkSpace;

  /// 作業スペースなし報告
  @override
  @JsonKey()
  final int noWorkSpace;

  /// 電源スポットの写真
  final List<String> _powerSourceSpots;

  /// 電源スポットの写真
  @override
  @JsonKey()
  List<String> get powerSourceSpots {
    if (_powerSourceSpots is EqualUnmodifiableListView)
      return _powerSourceSpots;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_powerSourceSpots);
  }

  /// DocumentReference
  @override
  @DocumentReferenceConverter()
  final DocumentReference<Object?> docRef;

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
            (identical(other.downloadSpeed, downloadSpeed) ||
                other.downloadSpeed == downloadSpeed) &&
            (identical(other.uploadSpeed, uploadSpeed) ||
                other.uploadSpeed == uploadSpeed) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.hasPowerSource, hasPowerSource) ||
                other.hasPowerSource == hasPowerSource) &&
            (identical(other.noPowerSource, noPowerSource) ||
                other.noPowerSource == noPowerSource) &&
            (identical(other.hasWorkSpace, hasWorkSpace) ||
                other.hasWorkSpace == hasWorkSpace) &&
            (identical(other.noWorkSpace, noWorkSpace) ||
                other.noWorkSpace == noWorkSpace) &&
            const DeepCollectionEquality()
                .equals(other._powerSourceSpots, _powerSourceSpots) &&
            (identical(other.docRef, docRef) || other.docRef == docRef));
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
      downloadSpeed,
      uploadSpeed,
      createdAt,
      updatedAt,
      hasPowerSource,
      noPowerSource,
      hasWorkSpace,
      noWorkSpace,
      const DeepCollectionEquality().hash(_powerSourceSpots),
      docRef);

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
      required final int downloadSpeed,
      required final int uploadSpeed,
      @TimestampConverter()
          required final DateTime createdAt,
      @TimestampConverter()
          required final DateTime updatedAt,
      final int hasPowerSource,
      final int noPowerSource,
      final int hasWorkSpace,
      final int noWorkSpace,
      final List<String> powerSourceSpots,
      @DocumentReferenceConverter()
          required final DocumentReference<Object?> docRef}) = _$_Facility;

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
  int get downloadSpeed;
  @override

  /// アップロード速度
  int get uploadSpeed;
  @override

  /// 作成日
  @TimestampConverter()
  DateTime get createdAt;
  @override

  /// 更新日
  @TimestampConverter()
  DateTime get updatedAt;
  @override

  /// 電源あり報告
  int get hasPowerSource;
  @override

  /// 電源なし報告
  int get noPowerSource;
  @override

  /// 作業スペースあり報告
  int get hasWorkSpace;
  @override

  /// 作業スペースなし報告
  int get noWorkSpace;
  @override

  /// 電源スポットの写真
  List<String> get powerSourceSpots;
  @override

  /// DocumentReference
  @DocumentReferenceConverter()
  DocumentReference<Object?> get docRef;
  @override
  @JsonKey(ignore: true)
  _$$_FacilityCopyWith<_$_Facility> get copyWith =>
      throw _privateConstructorUsedError;
}
