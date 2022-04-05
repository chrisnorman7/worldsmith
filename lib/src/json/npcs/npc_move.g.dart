// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'npc_move.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NpcMove _$NpcMoveFromJson(Map<String, dynamic> json) => NpcMove(
      locationMarkerId: json['locationMarkerId'] as String,
      z: (json['z'] as num?)?.toDouble() ?? 0.0,
      minMoveInterval: json['minMoveInterval'] as int? ?? 100,
      maxMoveInterval: json['maxMoveInterval'] as int? ?? 5000,
      moveSound: json['moveSound'] == null
          ? null
          : Sound.fromJson(json['moveSound'] as Map<String, dynamic>),
      walkingMode:
          $enumDecodeNullable(_$WalkingModeEnumMap, json['walkingMode']) ??
              WalkingMode.fast,
      stepSize: (json['stepSize'] as num?)?.toDouble(),
      startCommand: json['startCommand'] == null
          ? null
          : CallCommand.fromJson(json['startCommand'] as Map<String, dynamic>),
      moveCommand: json['moveCommand'] == null
          ? null
          : CallCommand.fromJson(json['moveCommand'] as Map<String, dynamic>),
      endCommand: json['endCommand'] == null
          ? null
          : CallCommand.fromJson(json['endCommand'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NpcMoveToJson(NpcMove instance) => <String, dynamic>{
      'locationMarkerId': instance.locationMarkerId,
      'z': instance.z,
      'minMoveInterval': instance.minMoveInterval,
      'maxMoveInterval': instance.maxMoveInterval,
      'moveSound': instance.moveSound,
      'walkingMode': _$WalkingModeEnumMap[instance.walkingMode],
      'stepSize': instance.stepSize,
      'startCommand': instance.startCommand,
      'moveCommand': instance.moveCommand,
      'endCommand': instance.endCommand,
    };

const _$WalkingModeEnumMap = {
  WalkingMode.stationary: 'stationary',
  WalkingMode.slow: 'slow',
  WalkingMode.fast: 'fast',
};
