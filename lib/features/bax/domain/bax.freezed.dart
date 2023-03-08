// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bax.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Bax _$BaxFromJson(Map<String, dynamic> json) {
  return _Bax.fromJson(json);
}

/// @nodoc
mixin _$Bax {
  /// 作成日
  @unionTimestampConverter
  UnionTimestamp get createdAt => throw _privateConstructorUsedError;

  /// FirebaseAuthのuid
  String get uid => throw _privateConstructorUsedError;

  /// ボーナス倍率
  ///
  /// キャンペーン等で1.2倍bax付与などを実装するために必要
  double get bonusRate => throw _privateConstructorUsedError;

  /// 付与理由のリスト
  ///
  /// ユーザーにポイントを付与する場合には
  ///
  /// このリストのpoint値の合計に bonusRate を掛け合わせた値を付与する必要あり
  List<BaxReason> get baxReasons => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BaxCopyWith<Bax> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BaxCopyWith<$Res> {
  factory $BaxCopyWith(Bax value, $Res Function(Bax) then) =
      _$BaxCopyWithImpl<$Res, Bax>;
  @useResult
  $Res call(
      {@unionTimestampConverter UnionTimestamp createdAt,
      String uid,
      double bonusRate,
      List<BaxReason> baxReasons});

  $UnionTimestampCopyWith<$Res> get createdAt;
}

/// @nodoc
class _$BaxCopyWithImpl<$Res, $Val extends Bax> implements $BaxCopyWith<$Res> {
  _$BaxCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? createdAt = null,
    Object? uid = null,
    Object? bonusRate = null,
    Object? baxReasons = null,
  }) {
    return _then(_value.copyWith(
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as UnionTimestamp,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      bonusRate: null == bonusRate
          ? _value.bonusRate
          : bonusRate // ignore: cast_nullable_to_non_nullable
              as double,
      baxReasons: null == baxReasons
          ? _value.baxReasons
          : baxReasons // ignore: cast_nullable_to_non_nullable
              as List<BaxReason>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UnionTimestampCopyWith<$Res> get createdAt {
    return $UnionTimestampCopyWith<$Res>(_value.createdAt, (value) {
      return _then(_value.copyWith(createdAt: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_BaxCopyWith<$Res> implements $BaxCopyWith<$Res> {
  factory _$$_BaxCopyWith(_$_Bax value, $Res Function(_$_Bax) then) =
      __$$_BaxCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@unionTimestampConverter UnionTimestamp createdAt,
      String uid,
      double bonusRate,
      List<BaxReason> baxReasons});

  @override
  $UnionTimestampCopyWith<$Res> get createdAt;
}

/// @nodoc
class __$$_BaxCopyWithImpl<$Res> extends _$BaxCopyWithImpl<$Res, _$_Bax>
    implements _$$_BaxCopyWith<$Res> {
  __$$_BaxCopyWithImpl(_$_Bax _value, $Res Function(_$_Bax) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? createdAt = null,
    Object? uid = null,
    Object? bonusRate = null,
    Object? baxReasons = null,
  }) {
    return _then(_$_Bax(
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as UnionTimestamp,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      bonusRate: null == bonusRate
          ? _value.bonusRate
          : bonusRate // ignore: cast_nullable_to_non_nullable
              as double,
      baxReasons: null == baxReasons
          ? _value._baxReasons
          : baxReasons // ignore: cast_nullable_to_non_nullable
              as List<BaxReason>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Bax extends _Bax {
  const _$_Bax(
      {@unionTimestampConverter
          this.createdAt = const UnionTimestamp.serverTimestamp(),
      required this.uid,
      this.bonusRate = 1.0,
      final List<BaxReason> baxReasons = const <BaxReason>[]})
      : _baxReasons = baxReasons,
        super._();

  factory _$_Bax.fromJson(Map<String, dynamic> json) => _$$_BaxFromJson(json);

  /// 作成日
  @override
  @JsonKey()
  @unionTimestampConverter
  final UnionTimestamp createdAt;

  /// FirebaseAuthのuid
  @override
  final String uid;

  /// ボーナス倍率
  ///
  /// キャンペーン等で1.2倍bax付与などを実装するために必要
  @override
  @JsonKey()
  final double bonusRate;

  /// 付与理由のリスト
  ///
  /// ユーザーにポイントを付与する場合には
  ///
  /// このリストのpoint値の合計に bonusRate を掛け合わせた値を付与する必要あり
  final List<BaxReason> _baxReasons;

  /// 付与理由のリスト
  ///
  /// ユーザーにポイントを付与する場合には
  ///
  /// このリストのpoint値の合計に bonusRate を掛け合わせた値を付与する必要あり
  @override
  @JsonKey()
  List<BaxReason> get baxReasons {
    if (_baxReasons is EqualUnmodifiableListView) return _baxReasons;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_baxReasons);
  }

  @override
  String toString() {
    return 'Bax(createdAt: $createdAt, uid: $uid, bonusRate: $bonusRate, baxReasons: $baxReasons)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Bax &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.bonusRate, bonusRate) ||
                other.bonusRate == bonusRate) &&
            const DeepCollectionEquality()
                .equals(other._baxReasons, _baxReasons));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, createdAt, uid, bonusRate,
      const DeepCollectionEquality().hash(_baxReasons));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_BaxCopyWith<_$_Bax> get copyWith =>
      __$$_BaxCopyWithImpl<_$_Bax>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BaxToJson(
      this,
    );
  }
}

abstract class _Bax extends Bax {
  const factory _Bax(
      {@unionTimestampConverter final UnionTimestamp createdAt,
      required final String uid,
      final double bonusRate,
      final List<BaxReason> baxReasons}) = _$_Bax;
  const _Bax._() : super._();

  factory _Bax.fromJson(Map<String, dynamic> json) = _$_Bax.fromJson;

  @override

  /// 作成日
  @unionTimestampConverter
  UnionTimestamp get createdAt;
  @override

  /// FirebaseAuthのuid
  String get uid;
  @override

  /// ボーナス倍率
  ///
  /// キャンペーン等で1.2倍bax付与などを実装するために必要
  double get bonusRate;
  @override

  /// 付与理由のリスト
  ///
  /// ユーザーにポイントを付与する場合には
  ///
  /// このリストのpoint値の合計に bonusRate を掛け合わせた値を付与する必要あり
  List<BaxReason> get baxReasons;
  @override
  @JsonKey(ignore: true)
  _$$_BaxCopyWith<_$_Bax> get copyWith => throw _privateConstructorUsedError;
}
