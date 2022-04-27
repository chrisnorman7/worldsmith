// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sound.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sound _$SoundFromJson(Map<String, dynamic> json) => Sound(
      id: json['id'] as String,
      gain: (json['gain'] as num?)?.toDouble() ?? 0.7,
    );

Map<String, dynamic> _$SoundToJson(Sound instance) => <String, dynamic>{
      'id': instance.id,
      'gain': instance.gain,
    };
