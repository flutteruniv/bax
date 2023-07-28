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

  /// geoHashを含んだ
  @GeoFirePointConverter()
  GeoFirePoint get geo => throw _privateConstructorUsedError;

  /// 住所
  String get address => throw _privateConstructorUsedError;

  /// ダウンロード速度
  double get downloadSpeed => throw _privateConstructorUsedError;

  /// アップロード速度
  double get uploadSpeed => throw _privateConstructorUsedError;

  /// 作成日
  @unionTimestampConverter
  UnionTimestamp get createdAt => throw _privateConstructorUsedError;

  /// 更新日
  @alwaysUseServerTimestampUnionTimestampConverter
  UnionTimestamp get updatedAt => throw _privateConstructorUsedError;

  /// 電源あり報告
  ///
  /// 報告者のuidを追加する
  Set<String> get hasPowerSource => throw _privateConstructorUsedError;

  /// 電源なし報告
  ///
  /// 報告者のuidを追加する
  Set<String> get noPowerSource => throw _privateConstructorUsedError;

  /// 作業スペースあり報告
  ///
  /// 報告者のuidを追加する
  Set<String> get hasWorkSpace => throw _privateConstructorUsedError;

  /// 作業スペースなし報告
  ///
  /// 報告者のuidを追加する
  Set<String> get noWorkSpace => throw _privateConstructorUsedError;

  /// 電源スポットの写真
  Set<String> get powerSourceSpots => throw _privateConstructorUsedError;

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
      @GeoFirePointConverter() GeoFirePoint geo,
      String address,
      double downloadSpeed,
      double uploadSpeed,
      @unionTimestampConverter UnionTimestamp createdAt,
      @alwaysUseServerTimestampUnionTimestampConverter UnionTimestamp updatedAt,
      Set<String> hasPowerSource,
      Set<String> noPowerSource,
      Set<String> hasWorkSpace,
      Set<String> noWorkSpace,
      Set<String> powerSourceSpots,
      @DocumentReferenceConverter() DocumentReference<Object?> docRef});

  $UnionTimestampCopyWith<$Res> get createdAt;
  $UnionTimestampCopyWith<$Res> get updatedAt;
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
    Object? geo = null,
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
      geo: null == geo
          ? _value.geo
          : geo // ignore: cast_nullable_to_non_nullable
              as GeoFirePoint,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      downloadSpeed: null == downloadSpeed
          ? _value.downloadSpeed
          : downloadSpeed // ignore: cast_nullable_to_non_nullable
              as double,
      uploadSpeed: null == uploadSpeed
          ? _value.uploadSpeed
          : uploadSpeed // ignore: cast_nullable_to_non_nullable
              as double,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as UnionTimestamp,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as UnionTimestamp,
      hasPowerSource: null == hasPowerSource
          ? _value.hasPowerSource
          : hasPowerSource // ignore: cast_nullable_to_non_nullable
              as Set<String>,
      noPowerSource: null == noPowerSource
          ? _value.noPowerSource
          : noPowerSource // ignore: cast_nullable_to_non_nullable
              as Set<String>,
      hasWorkSpace: null == hasWorkSpace
          ? _value.hasWorkSpace
          : hasWorkSpace // ignore: cast_nullable_to_non_nullable
              as Set<String>,
      noWorkSpace: null == noWorkSpace
          ? _value.noWorkSpace
          : noWorkSpace // ignore: cast_nullable_to_non_nullable
              as Set<String>,
      powerSourceSpots: null == powerSourceSpots
          ? _value.powerSourceSpots
          : powerSourceSpots // ignore: cast_nullable_to_non_nullable
              as Set<String>,
      docRef: null == docRef
          ? _value.docRef
          : docRef // ignore: cast_nullable_to_non_nullable
              as DocumentReference<Object?>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UnionTimestampCopyWith<$Res> get createdAt {
    return $UnionTimestampCopyWith<$Res>(_value.createdAt, (value) {
      return _then(_value.copyWith(createdAt: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $UnionTimestampCopyWith<$Res> get updatedAt {
    return $UnionTimestampCopyWith<$Res>(_value.updatedAt, (value) {
      return _then(_value.copyWith(updatedAt: value) as $Val);
    });
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
      @GeoFirePointConverter() GeoFirePoint geo,
      String address,
      double downloadSpeed,
      double uploadSpeed,
      @unionTimestampConverter UnionTimestamp createdAt,
      @alwaysUseServerTimestampUnionTimestampConverter UnionTimestamp updatedAt,
      Set<String> hasPowerSource,
      Set<String> noPowerSource,
      Set<String> hasWorkSpace,
      Set<String> noWorkSpace,
      Set<String> powerSourceSpots,
      @DocumentReferenceConverter() DocumentReference<Object?> docRef});

  @override
  $UnionTimestampCopyWith<$Res> get createdAt;
  @override
  $UnionTimestampCopyWith<$Res> get updatedAt;
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
    Object? geo = null,
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
      geo: null == geo
          ? _value.geo
          : geo // ignore: cast_nullable_to_non_nullable
              as GeoFirePoint,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      downloadSpeed: null == downloadSpeed
          ? _value.downloadSpeed
          : downloadSpeed // ignore: cast_nullable_to_non_nullable
              as double,
      uploadSpeed: null == uploadSpeed
          ? _value.uploadSpeed
          : uploadSpeed // ignore: cast_nullable_to_non_nullable
              as double,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as UnionTimestamp,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as UnionTimestamp,
      hasPowerSource: null == hasPowerSource
          ? _value._hasPowerSource
          : hasPowerSource // ignore: cast_nullable_to_non_nullable
              as Set<String>,
      noPowerSource: null == noPowerSource
          ? _value._noPowerSource
          : noPowerSource // ignore: cast_nullable_to_non_nullable
              as Set<String>,
      hasWorkSpace: null == hasWorkSpace
          ? _value._hasWorkSpace
          : hasWorkSpace // ignore: cast_nullable_to_non_nullable
              as Set<String>,
      noWorkSpace: null == noWorkSpace
          ? _value._noWorkSpace
          : noWorkSpace // ignore: cast_nullable_to_non_nullable
              as Set<String>,
      powerSourceSpots: null == powerSourceSpots
          ? _value._powerSourceSpots
          : powerSourceSpots // ignore: cast_nullable_to_non_nullable
              as Set<String>,
      docRef: null == docRef
          ? _value.docRef
          : docRef // ignore: cast_nullable_to_non_nullable
              as DocumentReference<Object?>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Facility extends _Facility {
  const _$_Facility(
      {required this.id,
      required this.name,
      @GeoFirePointConverter()
          required this.geo,
      required this.address,
      required this.downloadSpeed,
      required this.uploadSpeed,
      @unionTimestampConverter
          this.createdAt = const UnionTimestamp.serverTimestamp(),
      @alwaysUseServerTimestampUnionTimestampConverter
          this.updatedAt = const UnionTimestamp.serverTimestamp(),
      final Set<String> hasPowerSource = const <String>{},
      final Set<String> noPowerSource = const <String>{},
      final Set<String> hasWorkSpace = const <String>{},
      final Set<String> noWorkSpace = const <String>{},
      final Set<String> powerSourceSpots = const <String>{},
      @DocumentReferenceConverter()
          required this.docRef})
      : _hasPowerSource = hasPowerSource,
        _noPowerSource = noPowerSource,
        _hasWorkSpace = hasWorkSpace,
        _noWorkSpace = noWorkSpace,
        _powerSourceSpots = powerSourceSpots,
        super._();

  factory _$_Facility.fromJson(Map<String, dynamic> json) =>
      _$$_FacilityFromJson(json);

  /// 施設Id
  @override
  final String id;

  /// 施設の名前
  @override
  final String name;

  /// geoHashを含んだ
  @override
  @GeoFirePointConverter()
  final GeoFirePoint geo;

  /// 住所
  @override
  final String address;

  /// ダウンロード速度
  @override
  final double downloadSpeed;

  /// アップロード速度
  @override
  final double uploadSpeed;

  /// 作成日
  @override
  @JsonKey()
  @unionTimestampConverter
  final UnionTimestamp createdAt;

  /// 更新日
  @override
  @JsonKey()
  @alwaysUseServerTimestampUnionTimestampConverter
  final UnionTimestamp updatedAt;

  /// 電源あり報告
  ///
  /// 報告者のuidを追加する
  final Set<String> _hasPowerSource;

  /// 電源あり報告
  ///
  /// 報告者のuidを追加する
  @override
  @JsonKey()
  Set<String> get hasPowerSource {
    if (_hasPowerSource is EqualUnmodifiableSetView) return _hasPowerSource;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_hasPowerSource);
  }

  /// 電源なし報告
  ///
  /// 報告者のuidを追加する
  final Set<String> _noPowerSource;

  /// 電源なし報告
  ///
  /// 報告者のuidを追加する
  @override
  @JsonKey()
  Set<String> get noPowerSource {
    if (_noPowerSource is EqualUnmodifiableSetView) return _noPowerSource;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_noPowerSource);
  }

  /// 作業スペースあり報告
  ///
  /// 報告者のuidを追加する
  final Set<String> _hasWorkSpace;

  /// 作業スペースあり報告
  ///
  /// 報告者のuidを追加する
  @override
  @JsonKey()
  Set<String> get hasWorkSpace {
    if (_hasWorkSpace is EqualUnmodifiableSetView) return _hasWorkSpace;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_hasWorkSpace);
  }

  /// 作業スペースなし報告
  ///
  /// 報告者のuidを追加する
  final Set<String> _noWorkSpace;

  /// 作業スペースなし報告
  ///
  /// 報告者のuidを追加する
  @override
  @JsonKey()
  Set<String> get noWorkSpace {
    if (_noWorkSpace is EqualUnmodifiableSetView) return _noWorkSpace;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_noWorkSpace);
  }

  /// 電源スポットの写真
  final Set<String> _powerSourceSpots;

  /// 電源スポットの写真
  @override
  @JsonKey()
  Set<String> get powerSourceSpots {
    if (_powerSourceSpots is EqualUnmodifiableSetView) return _powerSourceSpots;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_powerSourceSpots);
  }

  /// DocumentReference
  @override
  @DocumentReferenceConverter()
  final DocumentReference<Object?> docRef;

  @override
  String toString() {
    return 'Facility(id: $id, name: $name, geo: $geo, address: $address, downloadSpeed: $downloadSpeed, uploadSpeed: $uploadSpeed, createdAt: $createdAt, updatedAt: $updatedAt, hasPowerSource: $hasPowerSource, noPowerSource: $noPowerSource, hasWorkSpace: $hasWorkSpace, noWorkSpace: $noWorkSpace, powerSourceSpots: $powerSourceSpots, docRef: $docRef)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Facility &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.geo, geo) || other.geo == geo) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.downloadSpeed, downloadSpeed) ||
                other.downloadSpeed == downloadSpeed) &&
            (identical(other.uploadSpeed, uploadSpeed) ||
                other.uploadSpeed == uploadSpeed) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            const DeepCollectionEquality()
                .equals(other._hasPowerSource, _hasPowerSource) &&
            const DeepCollectionEquality()
                .equals(other._noPowerSource, _noPowerSource) &&
            const DeepCollectionEquality()
                .equals(other._hasWorkSpace, _hasWorkSpace) &&
            const DeepCollectionEquality()
                .equals(other._noWorkSpace, _noWorkSpace) &&
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
      geo,
      address,
      downloadSpeed,
      uploadSpeed,
      createdAt,
      updatedAt,
      const DeepCollectionEquality().hash(_hasPowerSource),
      const DeepCollectionEquality().hash(_noPowerSource),
      const DeepCollectionEquality().hash(_hasWorkSpace),
      const DeepCollectionEquality().hash(_noWorkSpace),
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

abstract class _Facility extends Facility {
  const factory _Facility(
      {required final String id,
      required final String name,
      @GeoFirePointConverter()
          required final GeoFirePoint geo,
      required final String address,
      required final double downloadSpeed,
      required final double uploadSpeed,
      @unionTimestampConverter
          final UnionTimestamp createdAt,
      @alwaysUseServerTimestampUnionTimestampConverter
          final UnionTimestamp updatedAt,
      final Set<String> hasPowerSource,
      final Set<String> noPowerSource,
      final Set<String> hasWorkSpace,
      final Set<String> noWorkSpace,
      final Set<String> powerSourceSpots,
      @DocumentReferenceConverter()
          required final DocumentReference<Object?> docRef}) = _$_Facility;
  const _Facility._() : super._();

  factory _Facility.fromJson(Map<String, dynamic> json) = _$_Facility.fromJson;

  @override

  /// 施設Id
  String get id;
  @override

  /// 施設の名前
  String get name;
  @override

  /// geoHashを含んだ
  @GeoFirePointConverter()
  GeoFirePoint get geo;
  @override

  /// 住所
  String get address;
  @override

  /// ダウンロード速度
  double get downloadSpeed;
  @override

  /// アップロード速度
  double get uploadSpeed;
  @override

  /// 作成日
  @unionTimestampConverter
  UnionTimestamp get createdAt;
  @override

  /// 更新日
  @alwaysUseServerTimestampUnionTimestampConverter
  UnionTimestamp get updatedAt;
  @override

  /// 電源あり報告
  ///
  /// 報告者のuidを追加する
  Set<String> get hasPowerSource;
  @override

  /// 電源なし報告
  ///
  /// 報告者のuidを追加する
  Set<String> get noPowerSource;
  @override

  /// 作業スペースあり報告
  ///
  /// 報告者のuidを追加する
  Set<String> get hasWorkSpace;
  @override

  /// 作業スペースなし報告
  ///
  /// 報告者のuidを追加する
  Set<String> get noWorkSpace;
  @override

  /// 電源スポットの写真
  Set<String> get powerSourceSpots;
  @override

  /// DocumentReference
  @DocumentReferenceConverter()
  DocumentReference<Object?> get docRef;
  @override
  @JsonKey(ignore: true)
  _$$_FacilityCopyWith<_$_Facility> get copyWith =>
      throw _privateConstructorUsedError;
}
