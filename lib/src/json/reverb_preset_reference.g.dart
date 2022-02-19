// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reverb_preset_reference.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReverbPresetReference _$ReverbPresetReferenceFromJson(
        Map<String, dynamic> json) =>
    ReverbPresetReference(
      id: json['id'] as String,
      reverbPreset:
          ReverbPreset.fromJson(json['reverbPreset'] as Map<String, dynamic>),
      sound: json['sound'] == null
          ? null
          : CustomSound.fromJson(json['sound'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReverbPresetReferenceToJson(
        ReverbPresetReference instance) =>
    <String, dynamic>{
      'id': instance.id,
      'reverbPreset': instance.reverbPreset,
      'sound': instance.sound,
    };
