// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'call_command.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CallCommand _$CallCommandFromJson(Map<String, dynamic> json) => CallCommand(
      commandId: json['commandId'] as String,
      callAfter: json['callAfter'] as int?,
    );

Map<String, dynamic> _$CallCommandToJson(CallCommand instance) =>
    <String, dynamic>{
      'commandId': instance.commandId,
      'callAfter': instance.callAfter,
    };