// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_menu_options.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MainMenuOptions _$MainMenuOptionsFromJson(Map<String, dynamic> json) =>
    MainMenuOptions(
      options: json['options'] == null
          ? const MenuOptions(title: 'Main Menu')
          : MenuOptions.fromJson(json['options'] as Map<String, dynamic>),
      newGameTitle: json['newGameTitle'] as String? ?? 'Start New Game',
      savedGameTitle: json['savedGameTitle'] as String? ?? 'Play Saved Game',
      creditsTitle: json['creditsTitle'] as String? ?? 'Show Credits',
      exitTitle: json['exitTitle'] as String? ?? 'Exit',
    );

Map<String, dynamic> _$MainMenuOptionsToJson(MainMenuOptions instance) =>
    <String, dynamic>{
      'options': instance.options,
      'newGameTitle': instance.newGameTitle,
      'savedGameTitle': instance.savedGameTitle,
      'creditsTitle': instance.creditsTitle,
      'exitTitle': instance.exitTitle,
    };
