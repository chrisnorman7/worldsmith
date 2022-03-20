// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'play_rumble.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayRumble _$PlayRumbleFromJson(Map<String, dynamic> json) => PlayRumble(
      strength: (json['strength'] as num?)?.toDouble() ?? 0.7,
      duration: json['duration'] as int? ?? 500,
    );

Map<String, dynamic> _$PlayRumbleToJson(PlayRumble instance) =>
    <String, dynamic>{
      'strength': instance.strength,
      'duration': instance.duration,
    };
