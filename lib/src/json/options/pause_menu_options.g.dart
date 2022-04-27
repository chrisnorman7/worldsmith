// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pause_menu_options.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PauseMenuOptions _$PauseMenuOptionsFromJson(Map<String, dynamic> json) =>
    PauseMenuOptions(
      title: json['title'] as String? ?? 'Pause Menu',
      music: json['music'] == null
          ? null
          : Sound.fromJson(json['music'] as Map<String, dynamic>),
      fadeTime: (json['fadeTime'] as num?)?.toDouble(),
      zoneOverviewMessage: json['zoneOverviewMessage'] as String? ?? 'Show Map',
      zoneOverviewSound: json['zoneOverviewSound'] == null
          ? null
          : Sound.fromJson(json['zoneOverviewSound'] as Map<String, dynamic>),
      returnToGameMessage:
          json['returnToGameMessage'] as String? ?? 'Return To Game',
      returnToGameSound: json['returnToGameSound'] == null
          ? null
          : Sound.fromJson(json['returnToGameSound'] as Map<String, dynamic>),
      returnToMainMenuMessage:
          json['returnToMainMenuMessage'] as String? ?? 'Return To Main Menu',
      returnToMainMenuSound: json['returnToMainMenuSound'] == null
          ? null
          : Sound.fromJson(
              json['returnToMainMenuSound'] as Map<String, dynamic>),
      returnToMainMenuFadeTime:
          (json['returnToMainMenuFadeTime'] as num?)?.toDouble() ?? 3.0,
    );

Map<String, dynamic> _$PauseMenuOptionsToJson(PauseMenuOptions instance) =>
    <String, dynamic>{
      'title': instance.title,
      'music': instance.music,
      'fadeTime': instance.fadeTime,
      'zoneOverviewMessage': instance.zoneOverviewMessage,
      'zoneOverviewSound': instance.zoneOverviewSound,
      'returnToGameMessage': instance.returnToGameMessage,
      'returnToGameSound': instance.returnToGameSound,
      'returnToMainMenuMessage': instance.returnToMainMenuMessage,
      'returnToMainMenuSound': instance.returnToMainMenuSound,
      'returnToMainMenuFadeTime': instance.returnToMainMenuFadeTime,
    };
