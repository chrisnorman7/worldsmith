// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_preferences.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayerPreferences _$PlayerPreferencesFromJson(Map<String, dynamic> json) =>
    PlayerPreferences(
      interfaceSoundsGain:
          (json['interfaceSoundsGain'] as num?)?.toDouble() ?? 0.7,
      musicGain: (json['musicGain'] as num?)?.toDouble() ?? 0.7,
      ambianceGain: (json['ambianceGain'] as num?)?.toDouble() ?? 0.7,
      pannerStrategy: $enumDecodeNullable(
              _$DefaultPannerStrategyEnumMap, json['pannerStrategy']) ??
          DefaultPannerStrategy.stereo,
      turnSensitivity: json['turnSensitivity'] as int? ?? 3,
    );

Map<String, dynamic> _$PlayerPreferencesToJson(PlayerPreferences instance) =>
    <String, dynamic>{
      'interfaceSoundsGain': instance.interfaceSoundsGain,
      'musicGain': instance.musicGain,
      'ambianceGain': instance.ambianceGain,
      'pannerStrategy': _$DefaultPannerStrategyEnumMap[instance.pannerStrategy],
      'turnSensitivity': instance.turnSensitivity,
    };

const _$DefaultPannerStrategyEnumMap = {
  DefaultPannerStrategy.stereo: 'stereo',
  DefaultPannerStrategy.hrtf: 'hrtf',
};
