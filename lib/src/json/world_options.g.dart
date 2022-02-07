// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'world_options.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorldOptions _$WorldOptionsFromJson(Map<String, dynamic> json) => WorldOptions(
      mainMenuTitle: json['mainMenuTitle'] as String? ?? 'Main Menu',
      mainMenuMusicId: json['mainMenuMusicId'] as String?,
      framesPerSecond: json['framesPerSecond'] as int? ?? 60,
      creditsMenuItemTitle:
          json['creditsMenuItemTitle'] as String? ?? 'Credits',
      playNewGameMenuItemTitle:
          json['playNewGameMenuItemTitle'] as String? ?? 'Start New Game',
      playSavedGameMenuItemTitle:
          json['playSavedGameMenuItemTitle'] as String? ?? 'Play Saved Game',
      exitMenuItemTitle: json['exitMenuItemTitle'] as String? ?? 'Exit',
      menuMoveSoundId: json['menuMoveSoundId'] as String?,
      menuActivateSoundId: json['menuActivateSoundId'] as String?,
      creditsMenuTitle:
          json['creditsMenuTitle'] as String? ?? 'Acknowledgements',
      creditMusicId: json['creditMusicId'] as String?,
    );

Map<String, dynamic> _$WorldOptionsToJson(WorldOptions instance) =>
    <String, dynamic>{
      'mainMenuTitle': instance.mainMenuTitle,
      'mainMenuMusicId': instance.mainMenuMusicId,
      'framesPerSecond': instance.framesPerSecond,
      'playNewGameMenuItemTitle': instance.playNewGameMenuItemTitle,
      'playSavedGameMenuItemTitle': instance.playSavedGameMenuItemTitle,
      'creditsMenuItemTitle': instance.creditsMenuItemTitle,
      'exitMenuItemTitle': instance.exitMenuItemTitle,
      'menuMoveSoundId': instance.menuMoveSoundId,
      'menuActivateSoundId': instance.menuActivateSoundId,
      'creditsMenuTitle': instance.creditsMenuTitle,
      'creditMusicId': instance.creditMusicId,
    };
