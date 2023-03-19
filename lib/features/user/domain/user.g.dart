// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_User _$$_UserFromJson(Map<String, dynamic> json) => _$_User(
      createdAt: json['createdAt'] == null
          ? const UnionTimestamp.serverTimestamp()
          : unionTimestampConverter.fromJson(json['createdAt'] as Object),
      uid: json['uid'] as String,
      baxPoint: (json['baxPoint'] as num).toDouble(),
    );

Map<String, dynamic> _$$_UserToJson(_$_User instance) => <String, dynamic>{
      'createdAt': unionTimestampConverter.toJson(instance.createdAt),
      'uid': instance.uid,
      'baxPoint': instance.baxPoint,
    };
