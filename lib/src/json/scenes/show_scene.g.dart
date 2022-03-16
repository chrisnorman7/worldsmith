// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'show_scene.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShowScene _$ShowSceneFromJson(Map<String, dynamic> json) => ShowScene(
      sceneId: json['sceneId'] as String,
      callCommand: json['callCommand'] == null
          ? null
          : CallCommand.fromJson(json['callCommand'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ShowSceneToJson(ShowScene instance) => <String, dynamic>{
      'sceneId': instance.sceneId,
      'callCommand': instance.callCommand,
    };
