// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conditional.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Conditional _$ConditionalFromJson(Map<String, dynamic> json) => Conditional(
      questCondition: json['questCondition'] == null
          ? null
          : QuestCondition.fromJson(
              json['questCondition'] as Map<String, dynamic>),
      chance: json['chance'] as int? ?? 1,
      conditionFunctionName: json['conditionFunctionName'] as String?,
    );

Map<String, dynamic> _$ConditionalToJson(Conditional instance) =>
    <String, dynamic>{
      'questCondition': instance.questCondition,
      'chance': instance.chance,
      'conditionFunctionName': instance.conditionFunctionName,
    };
