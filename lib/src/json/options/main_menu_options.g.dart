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
      newGameString: json['newGameString'] as String? ?? 'Start New Game',
      newGameSound: json['newGameSound'] == null
          ? null
          : Sound.fromJson(json['newGameSound'] as Map<String, dynamic>),
      savedGameString: json['savedGameString'] as String? ?? 'Play Saved Game',
      savedGameSound: json['savedGameSound'] == null
          ? null
          : Sound.fromJson(json['savedGameSound'] as Map<String, dynamic>),
      creditsString: json['creditsString'] as String? ?? 'Show Credits',
      creditsSound: json['creditsSound'] == null
          ? null
          : Sound.fromJson(json['creditsSound'] as Map<String, dynamic>),
      controlsMenuString:
          json['controlsMenuString'] as String? ?? 'Review Game Controls',
      controlsMenuSound: json['controlsMenuSound'] == null
          ? null
          : Sound.fromJson(json['controlsMenuSound'] as Map<String, dynamic>),
      exitString: json['exitString'] as String? ?? 'Exit',
      exitSound: json['exitSound'] == null
          ? null
          : Sound.fromJson(json['exitSound'] as Map<String, dynamic>),
      onExitString:
          json['onExitString'] as String? ?? 'The game will now close.',
      onExitSound: json['onExitSound'] == null
          ? null
          : Sound.fromJson(json['onExitSound'] as Map<String, dynamic>),
      soundOptionsString:
          json['soundOptionsString'] as String? ?? 'Sound Options',
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
      'newGameString': instance.newGameString,
      'newGameSound': instance.newGameSound,
      'savedGameString': instance.savedGameString,
      'savedGameSound': instance.savedGameSound,
      'creditsString': instance.creditsString,
      'creditsSound': instance.creditsSound,
      'controlsMenuString': instance.controlsMenuString,
      'controlsMenuSound': instance.controlsMenuSound,
      'soundOptionsString': instance.soundOptionsString,
      'soundOptionsSound': instance.soundOptionsSound,
      'exitString': instance.exitString,
      'exitSound': instance.exitSound,
      'onExitString': instance.onExitString,
      'onExitSound': instance.onExitSound,
      'startGameCommandId': instance.startGameCommandId,
    };
