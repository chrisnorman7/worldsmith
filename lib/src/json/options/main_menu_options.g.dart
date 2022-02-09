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
      newGameTitle: json['newGameTitle'] as String? ?? 'Start New Game',
      savedGameTitle: json['savedGameTitle'] as String? ?? 'Play Saved Game',
      creditsTitle: json['creditsTitle'] as String? ?? 'Show Credits',
      exitTitle: json['exitTitle'] as String? ?? 'Exit',
    );

Map<String, dynamic> _$MainMenuOptionsToJson(MainMenuOptions instance) =>
    <String, dynamic>{
      'title': instance.title,
      'music': instance.music,
      'fadeTime': instance.fadeTime,
      'newGameTitle': instance.newGameTitle,
      'savedGameTitle': instance.savedGameTitle,
      'creditsTitle': instance.creditsTitle,
      'exitTitle': instance.exitTitle,
    };
