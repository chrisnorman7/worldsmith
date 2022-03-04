// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'zone.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Zone _$ZoneFromJson(Map<String, dynamic> json) => Zone(
      id: json['id'] as String,
      name: json['name'] as String,
      boxes: (json['boxes'] as List<dynamic>)
          .map((e) => Box.fromJson(e as Map<String, dynamic>))
          .toList(),
      defaultTerrainId: json['defaultTerrainId'] as String,
      music: json['music'] == null
          ? null
          : Sound.fromJson(json['music'] as Map<String, dynamic>),
      musicFadeTime: (json['musicFadeTime'] as num?)?.toDouble(),
      ambiances: (json['ambiances'] as List<dynamic>?)
          ?.map((e) => Sound.fromJson(e as Map<String, dynamic>))
          .toList(),
      topDownMap: json['topDownMap'] as bool? ?? true,
      edgeCommand: json['edgeCommand'] == null
          ? null
          : CallCommand.fromJson(json['edgeCommand'] as Map<String, dynamic>),
      turnAmount: json['turnAmount'] as int? ?? 45,
      objects: (json['objects'] as List<dynamic>?)
          ?.map((e) => ZoneObject.fromJson(e as Map<String, dynamic>))
          .toList(),
      locationMarkers: (json['locationMarkers'] as List<dynamic>?)
          ?.map((e) => LocationMarker.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ZoneToJson(Zone instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'boxes': instance.boxes,
      'defaultTerrainId': instance.defaultTerrainId,
      'music': instance.music,
      'musicFadeTime': instance.musicFadeTime,
      'ambiances': instance.ambiances,
      'topDownMap': instance.topDownMap,
      'edgeCommand': instance.edgeCommand,
      'turnAmount': instance.turnAmount,
      'objects': instance.objects,
      'locationMarkers': instance.locationMarkers,
    };
