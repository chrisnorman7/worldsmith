// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'zone_npc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ZoneNpc _$ZoneNpcFromJson(Map<String, dynamic> json) => ZoneNpc(
      npcId: json['npcId'] as String,
      initialCoordinates: Coordinates.fromJson(
          json['initialCoordinates'] as Map<String, dynamic>),
      moves: (json['moves'] as List<dynamic>?)
          ?.map((e) => NpcMove.fromJson(e as Map<String, dynamic>))
          .toList(),
      collision: json['collision'] == null
          ? null
          : NpcCollision.fromJson(json['collision'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ZoneNpcToJson(ZoneNpc instance) => <String, dynamic>{
      'npcId': instance.npcId,
      'initialCoordinates': instance.initialCoordinates,
      'moves': instance.moves,
      'collision': instance.collision,
    };
