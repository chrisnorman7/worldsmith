// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'world.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

World _$WorldFromJson(Map<String, dynamic> json) => World(
      title: json['title'] as String? ?? 'Untitled World',
      globalOptions: json['globalOptions'] == null
          ? const WorldOptions()
          : WorldOptions.fromJson(
              json['globalOptions'] as Map<String, dynamic>),
      soundOptions: json['soundOptions'] == null
          ? const SoundOptions()
          : SoundOptions.fromJson(json['soundOptions'] as Map<String, dynamic>),
      mainMenuOptions: json['mainMenuOptions'] == null
          ? const MainMenuOptions()
          : MainMenuOptions.fromJson(
              json['mainMenuOptions'] as Map<String, dynamic>),
      credits: (json['credits'] as List<dynamic>?)
              ?.map((e) => WorldCredit.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      creditsMenuOptions: json['creditsMenuOptions'] == null
          ? const MenuOptions(title: 'Credits')
          : MenuOptions.fromJson(
              json['creditsMenuOptions'] as Map<String, dynamic>),
      creditsAssetStore: json['creditsAssetStore'] == null
          ? const AssetStore(
              filename: 'assets/credits.json',
              destination: 'assets/credits',
              assets: [])
          : AssetStore.fromJson(
              json['creditsAssetStore'] as Map<String, dynamic>),
      musicAssetStore: json['musicAssetStore'] == null
          ? const AssetStore(
              filename: 'assets/music.json',
              destination: 'assets/music',
              assets: [])
          : AssetStore.fromJson(
              json['musicAssetStore'] as Map<String, dynamic>),
      interfaceSoundsAssetStore: json['interfaceSoundsAssetStore'] == null
          ? const AssetStore(
              filename: 'assets/interface.json',
              destination: 'assets/interface',
              assets: [])
          : AssetStore.fromJson(
              json['interfaceSoundsAssetStore'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WorldToJson(World instance) => <String, dynamic>{
      'title': instance.title,
      'globalOptions': instance.globalOptions,
      'soundOptions': instance.soundOptions,
      'mainMenuOptions': instance.mainMenuOptions,
      'credits': instance.credits,
      'creditsMenuOptions': instance.creditsMenuOptions,
      'creditsAssetStore': instance.creditsAssetStore,
      'musicAssetStore': instance.musicAssetStore,
      'interfaceSoundsAssetStore': instance.interfaceSoundsAssetStore,
    };
