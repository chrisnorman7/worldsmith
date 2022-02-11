// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sound_options.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SoundOptions _$SoundOptionsFromJson(Map<String, dynamic> json) => SoundOptions(
      defaultGain: (json['defaultGain'] as num?)?.toDouble() ?? 0.7,
      menuMoveSound: json['menuMoveSound'] == null
          ? null
          : Sound.fromJson(json['menuMoveSound'] as Map<String, dynamic>),
      menuActivateSound: json['menuActivateSound'] == null
          ? null
          : Sound.fromJson(json['menuActivateSound'] as Map<String, dynamic>),
      defaultPannerStrategy: $enumDecodeNullable(
              _$DefaultPannerStrategyEnumMap, json['defaultPannerStrategy']) ??
          DefaultPannerStrategy.stereo,
    );

Map<String, dynamic> _$SoundOptionsToJson(SoundOptions instance) =>
    <String, dynamic>{
      'defaultGain': instance.defaultGain,
      'menuMoveSound': instance.menuMoveSound,
      'menuActivateSound': instance.menuActivateSound,
      'defaultPannerStrategy':
          _$DefaultPannerStrategyEnumMap[instance.defaultPannerStrategy],
    };

const _$DefaultPannerStrategyEnumMap = {
  DefaultPannerStrategy.stereo: 'stereo',
  DefaultPannerStrategy.hrtf: 'hrtf',
};
