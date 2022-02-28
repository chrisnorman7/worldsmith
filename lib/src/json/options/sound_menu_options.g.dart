// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sound_menu_options.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SoundMenuOptions _$SoundMenuOptionsFromJson(Map<String, dynamic> json) =>
    SoundMenuOptions(
      title: json['title'] as String? ?? 'Sound',
      fadeTime: (json['fadeTime'] as num?)?.toDouble(),
      music: json['music'] == null
          ? null
          : Sound.fromJson(json['music'] as Map<String, dynamic>),
      gainAdjust: (json['gainAdjust'] as num?)?.toDouble() ?? 0.1,
      interfaceSoundsVolumeTitle:
          json['interfaceSoundsVolumeTitle'] as String? ??
              'Interface Sounds Volume',
      musicVolumeTitle: json['musicVolumeTitle'] as String? ?? 'Music Volume',
      ambianceSoundsVolumeTitle: json['ambianceSoundsVolumeTitle'] as String? ??
          'Ambiance Sounds Volume',
    );

Map<String, dynamic> _$SoundMenuOptionsToJson(SoundMenuOptions instance) =>
    <String, dynamic>{
      'title': instance.title,
      'music': instance.music,
      'fadeTime': instance.fadeTime,
      'gainAdjust': instance.gainAdjust,
      'interfaceSoundsVolumeTitle': instance.interfaceSoundsVolumeTitle,
      'musicVolumeTitle': instance.musicVolumeTitle,
      'ambianceSoundsVolumeTitle': instance.ambianceSoundsVolumeTitle,
    };
