// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'world_command.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorldCommand _$WorldCommandFromJson(Map<String, dynamic> json) => WorldCommand(
      id: json['id'] as String,
      name: json['name'] as String,
      message: json['message'] == null
          ? null
          : CustomMessage.fromJson(json['message'] as Map<String, dynamic>),
      localTeleport: json['localTeleport'] == null
          ? null
          : LocalTeleport.fromJson(
              json['localTeleport'] as Map<String, dynamic>),
      zoneTeleport: json['zoneTeleport'] == null
          ? null
          : ZoneTeleport.fromJson(json['zoneTeleport'] as Map<String, dynamic>),
      callCommand: json['callCommand'] == null
          ? null
          : CallCommand.fromJson(json['callCommand'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WorldCommandToJson(WorldCommand instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'message': instance.message,
      'localTeleport': instance.localTeleport,
      'zoneTeleport': instance.zoneTeleport,
      'callCommand': instance.callCommand,
    };