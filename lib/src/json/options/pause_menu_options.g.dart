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
      zoneOverviewLabel: json['zoneOverviewLabel'] as String? ?? 'Map Overview',
      returnToGameTitle:
          json['returnToGameTitle'] as String? ?? 'Return To Game',
    );

Map<String, dynamic> _$PauseMenuOptionsToJson(PauseMenuOptions instance) =>
    <String, dynamic>{
      'title': instance.title,
      'music': instance.music,
      'fadeTime': instance.fadeTime,
      'zoneOverviewLabel': instance.zoneOverviewLabel,
      'returnToGameTitle': instance.returnToGameTitle,
    };
