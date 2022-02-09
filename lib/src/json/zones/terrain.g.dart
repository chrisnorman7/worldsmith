// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'terrain.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Terrain _$TerrainFromJson(Map<String, dynamic> json) => Terrain(
      id: json['id'] as String,
      name: json['name'] as String,
      sound: Sound.fromJson(json['sound'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TerrainToJson(Terrain instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'sound': instance.sound,
    };
