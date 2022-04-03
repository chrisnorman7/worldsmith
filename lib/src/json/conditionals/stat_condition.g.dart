// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stat_condition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatCondition _$StatConditionFromJson(Map<String, dynamic> json) =>
    StatCondition(
      statId: json['statId'] as String,
      value: json['value'] as int,
      operator:
          $enumDecodeNullable(_$ConditionalOperatorEnumMap, json['operator']) ??
              ConditionalOperator.equal,
    );

Map<String, dynamic> _$StatConditionToJson(StatCondition instance) =>
    <String, dynamic>{
      'statId': instance.statId,
      'operator': _$ConditionalOperatorEnumMap[instance.operator],
      'value': instance.value,
    };

const _$ConditionalOperatorEnumMap = {
  ConditionalOperator.equal: 'equal',
  ConditionalOperator.notEqual: 'notEqual',
  ConditionalOperator.lessThan: 'lessThan',
  ConditionalOperator.lessEqual: 'lessEqual',
  ConditionalOperator.greaterThan: 'greaterThan',
  ConditionalOperator.greaterEqual: 'greaterEqual',
};
