// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sound_options.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SoundOptions _$SoundOptionsFromJson(Map<String, dynamic> json) => SoundOptions(
      menuMoveSoundId: json['menuMoveSoundId'] as String?,
      menuActivateSoundId: json['menuActivateSoundId'] as String?,
      defaultPannerStrategy: $enumDecodeNullable(
              _$DefaultPannerStrategyEnumMap, json['defaultPannerStrategy']) ??
          DefaultPannerStrategy.stereo,
    );

Map<String, dynamic> _$SoundOptionsToJson(SoundOptions instance) =>
    <String, dynamic>{
      'menuMoveSoundId': instance.menuMoveSoundId,
      'menuActivateSoundId': instance.menuActivateSoundId,
      'defaultPannerStrategy':
          _$DefaultPannerStrategyEnumMap[instance.defaultPannerStrategy],
    };

const _$DefaultPannerStrategyEnumMap = {
  DefaultPannerStrategy.stereo: 'stereo',
  DefaultPannerStrategy.hrtf: 'hrtf',
};
