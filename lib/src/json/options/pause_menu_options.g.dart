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
      zoneOverviewMessage: json['zoneOverviewMessage'] == null
          ? null
          : CustomMessage.fromJson(
              json['zoneOverviewMessage'] as Map<String, dynamic>),
      returnToGameMessage: json['returnToGameMessage'] == null
          ? null
          : CustomMessage.fromJson(
              json['returnToGameMessage'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PauseMenuOptionsToJson(PauseMenuOptions instance) =>
    <String, dynamic>{
      'title': instance.title,
      'music': instance.music,
      'fadeTime': instance.fadeTime,
      'zoneOverviewMessage': instance.zoneOverviewMessage,
      'returnToGameMessage': instance.returnToGameMessage,
    };
