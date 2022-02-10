// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'walking_options.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WalkingOptions _$WalkingOptionsFromJson(Map<String, dynamic> json) =>
    WalkingOptions(
      interval: json['interval'] as int,
      distance: (json['distance'] as num).toDouble(),
      sound: Sound.fromJson(json['sound'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WalkingOptionsToJson(WalkingOptions instance) =>
    <String, dynamic>{
      'interval': instance.interval,
      'distance': instance.distance,
      'sound': instance.sound,
    };
