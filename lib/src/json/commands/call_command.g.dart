// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'call_command.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CallCommand _$CallCommandFromJson(Map<String, dynamic> json) => CallCommand(
      commandId: json['commandId'] as String,
      conditions: (json['conditions'] as List<dynamic>?)
          ?.map((e) => Conditional.fromJson(e as Map<String, dynamic>))
          .toList(),
      callAfter: json['callAfter'] as int?,
    );

Map<String, dynamic> _$CallCommandToJson(CallCommand instance) =>
    <String, dynamic>{
      'conditions': instance.conditions,
      'commandId': instance.commandId,
      'callAfter': instance.callAfter,
    };
