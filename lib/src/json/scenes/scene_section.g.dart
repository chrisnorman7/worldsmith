// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scene_section.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SceneSection _$SceneSectionFromJson(Map<String, dynamic> json) => SceneSection(
      text: json['text'] as String?,
      sound: json['sound'] == null
          ? null
          : Sound.fromJson(json['sound'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SceneSectionToJson(SceneSection instance) =>
    <String, dynamic>{
      'text': instance.text,
      'sound': instance.sound,
    };
