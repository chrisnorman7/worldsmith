// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'npc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Npc _$NpcFromJson(Map<String, dynamic> json) => Npc(
      id: json['id'] as String,
      initialCoordinates: Coordinates.fromJson(
          json['initialCoordinates'] as Map<String, dynamic>),
      stats: Statistics.fromJson(json['stats'] as Map<String, dynamic>),
      z: (json['z'] as num?)?.toDouble() ?? 0.0,
      name: json['name'] as String? ?? 'Unnamed NPC',
      ambiance: json['ambiance'] == null
          ? null
          : Sound.fromJson(json['ambiance'] as Map<String, dynamic>),
      moves: (json['moves'] as List<dynamic>?)
          ?.map((e) => NpcMove.fromJson(e as Map<String, dynamic>))
          .toList(),
      collision: json['collision'] == null
          ? null
          : NpcCollision.fromJson(json['collision'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NpcToJson(Npc instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'initialCoordinates': instance.initialCoordinates,
      'z': instance.z,
      'stats': instance.stats,
      'ambiance': instance.ambiance,
      'moves': instance.moves,
      'collision': instance.collision,
    };
