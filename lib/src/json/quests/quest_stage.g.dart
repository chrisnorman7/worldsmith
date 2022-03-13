// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quest_stage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestStage _$QuestStageFromJson(Map<String, dynamic> json) => QuestStage(
      id: json['id'] as String,
      description: json['description'] as String?,
      sound: json['sound'] == null
          ? null
          : Sound.fromJson(json['sound'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$QuestStageToJson(QuestStage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'sound': instance.sound,
    };
