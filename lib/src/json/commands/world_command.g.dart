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
      walkingMode:
          $enumDecodeNullable(_$WalkingModeEnumMap, json['walkingMode']),
      customCommandName: json['customCommandName'] as String?,
      callCommand: json['callCommand'] == null
          ? null
          : CallCommand.fromJson(json['callCommand'] as Map<String, dynamic>),
      startConversation: json['startConversation'] == null
          ? null
          : StartConversation.fromJson(
              json['startConversation'] as Map<String, dynamic>),
      setQuestStage: json['setQuestStage'] == null
          ? null
          : SetQuestStage.fromJson(
              json['setQuestStage'] as Map<String, dynamic>),
      returnToMainMenu: json['returnToMainMenu'] == null
          ? null
          : ReturnToMainMenu.fromJson(
              json['returnToMainMenu'] as Map<String, dynamic>),
      showScene: json['showScene'] == null
          ? null
          : ShowScene.fromJson(json['showScene'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WorldCommandToJson(WorldCommand instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'message': instance.message,
      'localTeleport': instance.localTeleport,
      'zoneTeleport': instance.zoneTeleport,
      'walkingMode': _$WalkingModeEnumMap[instance.walkingMode],
      'customCommandName': instance.customCommandName,
      'callCommand': instance.callCommand,
      'startConversation': instance.startConversation,
      'setQuestStage': instance.setQuestStage,
      'returnToMainMenu': instance.returnToMainMenu,
      'showScene': instance.showScene,
    };

const _$WalkingModeEnumMap = {
  WalkingMode.stationary: 'stationary',
  WalkingMode.slow: 'slow',
  WalkingMode.fast: 'fast',
};
