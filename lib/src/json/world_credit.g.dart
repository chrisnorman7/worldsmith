// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'world_credit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorldCredit _$WorldCreditFromJson(Map<String, dynamic> json) => WorldCredit(
      title: json['title'] as String,
      url: json['url'] as String?,
      sound: json['sound'] == null
          ? null
          : Sound.fromJson(json['sound'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WorldCreditToJson(WorldCredit instance) =>
    <String, dynamic>{
      'title': instance.title,
      'url': instance.url,
      'sound': instance.sound,
    };
