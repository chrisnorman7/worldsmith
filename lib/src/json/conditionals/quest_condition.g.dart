// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quest_condition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestCondition _$QuestConditionFromJson(Map<String, dynamic> json) =>
    QuestCondition(
      questId: json['questId'] as String,
      stageId: json['stageId'] as String?,
    );

Map<String, dynamic> _$QuestConditionToJson(QuestCondition instance) =>
    <String, dynamic>{
      'questId': instance.questId,
      'stageId': instance.stageId,
    };
