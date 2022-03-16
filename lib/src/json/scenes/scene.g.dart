// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scene.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Scene _$SceneFromJson(Map<String, dynamic> json) => Scene(
      id: json['id'] as String,
      name: json['name'] as String,
      sections: (json['sections'] as List<dynamic>)
          .map((e) => SceneSection.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SceneToJson(Scene instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'sections': instance.sections,
    };
