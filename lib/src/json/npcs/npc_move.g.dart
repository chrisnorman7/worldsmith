// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'npc_move.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NpcMove _$NpcMoveFromJson(Map<String, dynamic> json) => NpcMove(
      locationMarkerId: json['locationMarkerId'] as String,
      minMoveInterval: json['minMoveInterval'] as int? ?? 100,
      maxMoveInterval: json['maxMoveInterval'] as int? ?? 5000,
      moveSound: json['moveSound'] == null
          ? null
          : Sound.fromJson(json['moveSound'] as Map<String, dynamic>),
      walkingMode:
          $enumDecodeNullable(_$WalkingModeEnumMap, json['walkingMode']),
    );

Map<String, dynamic> _$NpcMoveToJson(NpcMove instance) => <String, dynamic>{
      'locationMarkerId': instance.locationMarkerId,
      'minMoveInterval': instance.minMoveInterval,
      'maxMoveInterval': instance.maxMoveInterval,
      'moveSound': instance.moveSound,
      'walkingMode': _$WalkingModeEnumMap[instance.walkingMode],
    };

const _$WalkingModeEnumMap = {
  WalkingMode.stationary: 'stationary',
  WalkingMode.slow: 'slow',
  WalkingMode.fast: 'fast',
};
