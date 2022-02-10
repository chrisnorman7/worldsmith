// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'terrain.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Terrain _$TerrainFromJson(Map<String, dynamic> json) => Terrain(
      id: json['id'] as String,
      name: json['name'] as String,
      slowWalk:
          WalkingOptions.fromJson(json['slowWalk'] as Map<String, dynamic>),
      fastWalk:
          WalkingOptions.fromJson(json['fastWalk'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TerrainToJson(Terrain instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slowWalk': instance.slowWalk,
      'fastWalk': instance.fastWalk,
    };
