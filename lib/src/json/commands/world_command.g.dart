// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'world_command.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorldCommand _$WorldCommandFromJson(Map<String, dynamic> json) => WorldCommand(
      id: json['id'] as String,
      name: json['name'] as String,
      text: json['text'] as String?,
      sound: json['sound'] == null
          ? null
          : CustomSound.fromJson(json['sound'] as Map<String, dynamic>),
      zoneTeleport: json['zoneTeleport'] == null
          ? null
          : ZoneTeleport.fromJson(json['zoneTeleport'] as Map<String, dynamic>),
      walkingMode:
          $enumDecodeNullable(_$WalkingModeEnumMap, json['walkingMode']),
      customCommandName: json['customCommandName'] as String?,
      callCommands: (json['callCommands'] as List<dynamic>?)
          ?.map((e) => CallCommand.fromJson(e as Map<String, dynamic>))
          .toList(),
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
      playRumble: json['playRumble'] == null
          ? null
          : PlayRumble.fromJson(json['playRumble'] as Map<String, dynamic>),
      url: json['url'] as String?,
    );

Map<String, dynamic> _$WorldCommandToJson(WorldCommand instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'text': instance.text,
      'sound': instance.sound,
      'zoneTeleport': instance.zoneTeleport,
      'walkingMode': _$WalkingModeEnumMap[instance.walkingMode],
      'customCommandName': instance.customCommandName,
      'callCommands': instance.callCommands,
      'startConversation': instance.startConversation,
      'setQuestStage': instance.setQuestStage,
      'returnToMainMenu': instance.returnToMainMenu,
      'showScene': instance.showScene,
      'playRumble': instance.playRumble,
      'url': instance.url,
    };

const _$WalkingModeEnumMap = {
  WalkingMode.stationary: 'stationary',
  WalkingMode.slow: 'slow',
  WalkingMode.fast: 'fast',
};
