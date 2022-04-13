// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'npc_collision.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NpcCollision _$NpcCollisionFromJson(Map<String, dynamic> json) => NpcCollision(
      callCommand: json['callCommand'] == null
          ? null
          : CallCommand.fromJson(json['callCommand'] as Map<String, dynamic>),
      distance: (json['distance'] as num?)?.toDouble() ?? 1.0,
      collideWithNpcs: json['collideWithNpcs'] as bool? ?? false,
      collideWithPlayer: json['collideWithPlayer'] as bool? ?? true,
      collideWithObjects: json['collideWithObjects'] as bool? ?? false,
    );

Map<String, dynamic> _$NpcCollisionToJson(NpcCollision instance) =>
    <String, dynamic>{
      'callCommand': instance.callCommand,
      'distance': instance.distance,
      'collideWithPlayer': instance.collideWithPlayer,
      'collideWithNpcs': instance.collideWithNpcs,
      'collideWithObjects': instance.collideWithObjects,
    };
