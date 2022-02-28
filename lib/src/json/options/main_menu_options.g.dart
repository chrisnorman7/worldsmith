// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_menu_options.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MainMenuOptions _$MainMenuOptionsFromJson(Map<String, dynamic> json) =>
    MainMenuOptions(
      title: json['title'] as String? ?? 'Main Menu',
      music: json['music'] == null
          ? null
          : Sound.fromJson(json['music'] as Map<String, dynamic>),
      fadeTime: (json['fadeTime'] as num?)?.toDouble() ?? 4.0,
      newGameMessage: json['newGameMessage'] == null
          ? null
          : CustomMessage.fromJson(
              json['newGameMessage'] as Map<String, dynamic>),
      savedGameMessage: json['savedGameMessage'] == null
          ? null
          : CustomMessage.fromJson(
              json['savedGameMessage'] as Map<String, dynamic>),
      creditsMessage: json['creditsMessage'] == null
          ? null
          : CustomMessage.fromJson(
              json['creditsMessage'] as Map<String, dynamic>),
      soundOptionsMessage: json['soundOptionsMessage'] == null
          ? null
          : CustomMessage.fromJson(
              json['soundOptionsMessage'] as Map<String, dynamic>),
      exitMessage: json['exitMessage'] == null
          ? null
          : CustomMessage.fromJson(json['exitMessage'] as Map<String, dynamic>),
      onExitMessage: json['onExitMessage'] == null
          ? null
          : CustomMessage.fromJson(
              json['onExitMessage'] as Map<String, dynamic>),
      startGameCommandId: json['startGameCommandId'] as String?,
    );

Map<String, dynamic> _$MainMenuOptionsToJson(MainMenuOptions instance) =>
    <String, dynamic>{
      'title': instance.title,
      'music': instance.music,
      'fadeTime': instance.fadeTime,
      'newGameMessage': instance.newGameMessage,
      'savedGameMessage': instance.savedGameMessage,
      'creditsMessage': instance.creditsMessage,
      'soundOptionsMessage': instance.soundOptionsMessage,
      'exitMessage': instance.exitMessage,
      'onExitMessage': instance.onExitMessage,
      'startGameCommandId': instance.startGameCommandId,
    };
