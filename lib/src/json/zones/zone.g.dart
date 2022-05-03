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
      musicFadeGain: (json['musicFadeGain'] as num?)?.toDouble() ?? 0.1,
      ambianceFadeTime: (json['ambianceFadeTime'] as num?)?.toDouble(),
      ambianceFadeGain: (json['ambianceFadeGain'] as num?)?.toDouble() ?? 0.1,
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
      npcs: (json['npcs'] as List<dynamic>?)
          ?.map((e) => ZoneNpc.fromJson(e as Map<String, dynamic>))
          .toList(),
      lookAroundDistance: json['lookAroundDistance'] as int? ?? 50,
    );

Map<String, dynamic> _$ZoneToJson(Zone instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'boxes': instance.boxes,
      'defaultTerrainId': instance.defaultTerrainId,
      'music': instance.music,
      'musicFadeTime': instance.musicFadeTime,
      'musicFadeGain': instance.musicFadeGain,
      'ambianceFadeTime': instance.ambianceFadeTime,
      'ambianceFadeGain': instance.ambianceFadeGain,
      'ambiances': instance.ambiances,
      'topDownMap': instance.topDownMap,
      'edgeCommand': instance.edgeCommand,
      'turnAmount': instance.turnAmount,
      'objects': instance.objects,
      'locationMarkers': instance.locationMarkers,
      'npcs': instance.npcs,
      'lookAroundDistance': instance.lookAroundDistance,
    };
