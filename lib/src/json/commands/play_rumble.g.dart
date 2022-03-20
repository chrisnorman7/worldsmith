// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'play_rumble.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayRumble _$PlayRumbleFromJson(Map<String, dynamic> json) => PlayRumble(
      leftFrequency: json['leftFrequency'] as int? ?? 65535,
      rightFrequency: json['rightFrequency'] as int? ?? 65535,
      duration: json['duration'] as int? ?? 500,
    );

Map<String, dynamic> _$PlayRumbleToJson(PlayRumble instance) =>
    <String, dynamic>{
      'leftFrequency': instance.leftFrequency,
      'rightFrequency': instance.rightFrequency,
      'duration': instance.duration,
    };
