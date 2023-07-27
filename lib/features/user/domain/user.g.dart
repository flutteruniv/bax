// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_User _$$_UserFromJson(Map<String, dynamic> json) => _$_User(
      baxPoint: (json['baxPoint'] as num?)?.toDouble() ?? 0.0,
      isPro: json['isPro'] as bool? ?? false,
      languageCode: $enumDecodeNullable(_$LTypeEnumMap, json['languageCode']),
    );

Map<String, dynamic> _$$_UserToJson(_$_User instance) => <String, dynamic>{
      'baxPoint': instance.baxPoint,
      'isPro': instance.isPro,
      'languageCode': _$LTypeEnumMap[instance.languageCode],
    };

const _$LTypeEnumMap = {
  LType.en: 'en',
  LType.ja: 'ja',
};
