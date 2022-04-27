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
      newGameMessage: json['newGameMessage'] as String? ?? 'Start New Game',
      newGameSound: json['newGameSound'] == null
          ? null
          : Sound.fromJson(json['newGameSound'] as Map<String, dynamic>),
      savedGameMessage:
          json['savedGameMessage'] as String? ?? 'Play Saved Game',
      savedGameSound: json['savedGameSound'] == null
          ? null
          : Sound.fromJson(json['savedGameSound'] as Map<String, dynamic>),
      creditsMessage: json['creditsMessage'] as String? ?? 'Show Credits',
      creditsSound: json['creditsSound'] == null
          ? null
          : Sound.fromJson(json['creditsSound'] as Map<String, dynamic>),
      exitMessage: json['exitMessage'] as String? ?? 'Exit',
      exitSound: json['exitSound'] == null
          ? null
          : Sound.fromJson(json['exitSound'] as Map<String, dynamic>),
      onExitMessage:
          json['onExitMessage'] as String? ?? 'The game will now close.',
      onExitSound: json['onExitSound'] == null
          ? null
          : Sound.fromJson(json['onExitSound'] as Map<String, dynamic>),
      soundOptionsMessage:
          json['soundOptionsMessage'] as String? ?? 'Sound Options',
      soundOptionsSound: json['soundOptionsSound'] == null
          ? null
          : Sound.fromJson(json['soundOptionsSound'] as Map<String, dynamic>),
      startGameCommandId: json['startGameCommandId'] as String?,
    );

Map<String, dynamic> _$MainMenuOptionsToJson(MainMenuOptions instance) =>
    <String, dynamic>{
      'title': instance.title,
      'music': instance.music,
      'fadeTime': instance.fadeTime,
      'newGameMessage': instance.newGameMessage,
      'newGameSound': instance.newGameSound,
      'savedGameMessage': instance.savedGameMessage,
      'savedGameSound': instance.savedGameSound,
      'creditsMessage': instance.creditsMessage,
      'creditsSound': instance.creditsSound,
      'soundOptionsMessage': instance.soundOptionsMessage,
      'soundOptionsSound': instance.soundOptionsSound,
      'exitMessage': instance.exitMessage,
      'exitSound': instance.exitSound,
      'onExitMessage': instance.onExitMessage,
      'onExitSound': instance.onExitSound,
      'startGameCommandId': instance.startGameCommandId,
    };
