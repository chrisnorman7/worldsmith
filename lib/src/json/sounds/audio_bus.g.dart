// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_bus.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AudioBus _$AudioBusFromJson(Map<String, dynamic> json) => AudioBus(
      id: json['id'] as String,
      name: json['name'] as String,
      reverbId: json['reverbId'] as String?,
      gain: (json['gain'] as num?)?.toDouble(),
      panningType:
          $enumDecodeNullable(_$PanningTypeEnumMap, json['panningType']) ??
              PanningType.direct,
      x: (json['x'] as num?)?.toDouble() ?? 0.0,
      y: (json['y'] as num?)?.toDouble() ?? 0.0,
      z: (json['z'] as num?)?.toDouble() ?? 0.0,
      testSound: json['testSound'] == null
          ? null
          : CustomSound.fromJson(json['testSound'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AudioBusToJson(AudioBus instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'reverbId': instance.reverbId,
      'gain': instance.gain,
      'panningType': _$PanningTypeEnumMap[instance.panningType],
      'x': instance.x,
      'y': instance.y,
      'z': instance.z,
      'testSound': instance.testSound,
    };

const _$PanningTypeEnumMap = {
  PanningType.direct: 'direct',
  PanningType.angular: 'angular',
  PanningType.scalar: 'scalar',
  PanningType.threeD: 'threeD',
};
