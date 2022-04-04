// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'npc_collision.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NpcCollision _$NpcCollisionFromJson(Map<String, dynamic> json) => NpcCollision(
      commandId: json['commandId'] as String,
      distance: (json['distance'] as num?)?.toDouble() ?? 1.0,
      collideWithNpcs: json['collideWithNpcs'] as bool? ?? false,
      collideWithPlayer: json['collideWithPlayer'] as bool? ?? true,
    );

Map<String, dynamic> _$NpcCollisionToJson(NpcCollision instance) =>
    <String, dynamic>{
      'commandId': instance.commandId,
      'distance': instance.distance,
      'collideWithPlayer': instance.collideWithPlayer,
      'collideWithNpcs': instance.collideWithNpcs,
    };
