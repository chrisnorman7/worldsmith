// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'npc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Npc _$NpcFromJson(Map<String, dynamic> json) => Npc(
      id: json['id'] as String,
      stats: Statistics.fromJson(json['stats'] as Map<String, dynamic>),
      name: json['name'] as String? ?? 'Unnamed NPC',
      ambiance: json['ambiance'] == null
          ? null
          : Sound.fromJson(json['ambiance'] as Map<String, dynamic>),
      icon: json['icon'] == null
          ? null
          : Sound.fromJson(json['icon'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NpcToJson(Npc instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'stats': instance.stats,
      'ambiance': instance.ambiance,
      'icon': instance.icon,
    };
