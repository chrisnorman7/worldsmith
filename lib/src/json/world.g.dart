// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'world.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

World _$WorldFromJson(Map<String, dynamic> json) => World(
      title: json['title'] as String,
      options: WorldOptions.fromJson(json['options'] as Map<String, dynamic>),
      credits: (json['credits'] as List<dynamic>)
          .map((e) => WorldCredit.fromJson(e as Map<String, dynamic>))
          .toList(),
      creditsAssetStore: AssetStore.fromJson(
          json['creditsAssetStore'] as Map<String, dynamic>),
      musicAssetStore:
          AssetStore.fromJson(json['musicAssetStore'] as Map<String, dynamic>),
      interfaceSoundsAssetStore: AssetStore.fromJson(
          json['interfaceSoundsAssetStore'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WorldToJson(World instance) => <String, dynamic>{
      'title': instance.title,
      'options': instance.options,
      'credits': instance.credits,
      'creditsAssetStore': instance.creditsAssetStore,
      'musicAssetStore': instance.musicAssetStore,
      'interfaceSoundsAssetStore': instance.interfaceSoundsAssetStore,
    };
