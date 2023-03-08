// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bax.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Bax _$$_BaxFromJson(Map<String, dynamic> json) => _$_Bax(
      createdAt: json['createdAt'] == null
          ? const UnionTimestamp.serverTimestamp()
          : unionTimestampConverter.fromJson(json['createdAt'] as Object),
      uid: json['uid'] as String,
      bonusRate: (json['bonusRate'] as num?)?.toDouble() ?? 1.0,
      baxReasons: (json['baxReasons'] as List<dynamic>?)
              ?.map((e) => BaxReason.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <BaxReason>[],
    );

Map<String, dynamic> _$$_BaxToJson(_$_Bax instance) => <String, dynamic>{
      'createdAt': unionTimestampConverter.toJson(instance.createdAt),
      'uid': instance.uid,
      'bonusRate': instance.bonusRate,
      'baxReasons': instance.baxReasons,
    };
