// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'world_options.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorldOptions _$WorldOptionsFromJson(Map<String, dynamic> json) => WorldOptions(
      version: json['version'] as String? ?? '0.0.0',
      framesPerSecond: json['framesPerSecond'] as int? ?? 60,
      orgName: json['orgName'] as String? ?? 'com.example',
      appName: json['appName'] as String? ?? 'untitled_game',
    );

Map<String, dynamic> _$WorldOptionsToJson(WorldOptions instance) =>
    <String, dynamic>{
      'version': instance.version,
      'framesPerSecond': instance.framesPerSecond,
      'orgName': instance.orgName,
      'appName': instance.appName,
    };
