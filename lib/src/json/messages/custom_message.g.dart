// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomMessage _$CustomMessageFromJson(Map<String, dynamic> json) =>
    CustomMessage(
      text: json['text'] as String?,
      sound: json['sound'] == null
          ? null
          : CustomSound.fromJson(json['sound'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CustomMessageToJson(CustomMessage instance) =>
    <String, dynamic>{
      'text': instance.text,
      'sound': instance.sound,
    };
