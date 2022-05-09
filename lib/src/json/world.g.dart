// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'world.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

World _$WorldFromJson(Map<String, dynamic> json) => World(
      title: json['title'] as String? ?? 'Untitled World',
      globalOptions: json['globalOptions'] == null
          ? null
          : WorldOptions.fromJson(
              json['globalOptions'] as Map<String, dynamic>),
      soundOptions: json['soundOptions'] == null
          ? null
          : SoundOptions.fromJson(json['soundOptions'] as Map<String, dynamic>),
      mainMenuOptions: json['mainMenuOptions'] == null
          ? null
          : MainMenuOptions.fromJson(
              json['mainMenuOptions'] as Map<String, dynamic>),
      credits: (json['credits'] as List<dynamic>?)
          ?.map((e) => WorldCredit.fromJson(e as Map<String, dynamic>))
          .toList(),
      creditsMenuOptions: json['creditsMenuOptions'] == null
          ? null
          : CreditsMenuOptions.fromJson(
              json['creditsMenuOptions'] as Map<String, dynamic>),
      soundMenuOptions: json['soundMenuOptions'] == null
          ? null
          : SoundMenuOptions.fromJson(
              json['soundMenuOptions'] as Map<String, dynamic>),
      creditsAssets: (json['creditsAssets'] as List<dynamic>?)
          ?.map((e) =>
              AssetReferenceReference.fromJson(e as Map<String, dynamic>))
          .toList(),
      musicAssets: (json['musicAssets'] as List<dynamic>?)
          ?.map((e) =>
              AssetReferenceReference.fromJson(e as Map<String, dynamic>))
          .toList(),
      interfaceSoundsAssets: (json['interfaceSoundsAssets'] as List<dynamic>?)
          ?.map((e) =>
              AssetReferenceReference.fromJson(e as Map<String, dynamic>))
          .toList(),
      equipmentAssets: (json['equipmentAssets'] as List<dynamic>?)
          ?.map((e) =>
              AssetReferenceReference.fromJson(e as Map<String, dynamic>))
          .toList(),
      terrainAssets: (json['terrainAssets'] as List<dynamic>?)
          ?.map((e) =>
              AssetReferenceReference.fromJson(e as Map<String, dynamic>))
          .toList(),
      ambianceAssets: (json['ambianceAssets'] as List<dynamic>?)
          ?.map((e) =>
              AssetReferenceReference.fromJson(e as Map<String, dynamic>))
          .toList(),
      conversationAssets: (json['conversationAssets'] as List<dynamic>?)
          ?.map((e) =>
              AssetReferenceReference.fromJson(e as Map<String, dynamic>))
          .toList(),
      questAssets: (json['questAssets'] as List<dynamic>?)
          ?.map((e) =>
              AssetReferenceReference.fromJson(e as Map<String, dynamic>))
          .toList(),
      directions: (json['directions'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
      equipmentPositions: (json['equipmentPositions'] as List<dynamic>?)
          ?.map((e) => EquipmentPosition.fromJson(e as Map<String, dynamic>))
          .toList(),
      terrains: (json['terrains'] as List<dynamic>?)
          ?.map((e) => Terrain.fromJson(e as Map<String, dynamic>))
          .toList(),
      zones: (json['zones'] as List<dynamic>?)
          ?.map((e) => Zone.fromJson(e as Map<String, dynamic>))
          .toList(),
      pauseMenuOptions: json['pauseMenuOptions'] == null
          ? null
          : PauseMenuOptions.fromJson(
              json['pauseMenuOptions'] as Map<String, dynamic>),
      reverbs: (json['reverbs'] as List<dynamic>?)
          ?.map(
              (e) => ReverbPresetReference.fromJson(e as Map<String, dynamic>))
          .toList(),
      commandCategories: (json['commandCategories'] as List<dynamic>?)
          ?.map((e) => CommandCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
      defaultPlayerPreferences: json['defaultPlayerPreferences'] == null
          ? null
          : PlayerPreferences.fromJson(
              json['defaultPlayerPreferences'] as Map<String, dynamic>),
      conversationCategories: (json['conversationCategories'] as List<dynamic>?)
          ?.map((e) => ConversationCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
      quests: (json['quests'] as List<dynamic>?)
          ?.map((e) => Quest.fromJson(e as Map<String, dynamic>))
          .toList(),
      questMenuOptions: json['questMenuOptions'] == null
          ? null
          : QuestMenuOptions.fromJson(
              json['questMenuOptions'] as Map<String, dynamic>),
      scenes: (json['scenes'] as List<dynamic>?)
          ?.map((e) => Scene.fromJson(e as Map<String, dynamic>))
          .toList(),
      stats: (json['stats'] as List<dynamic>?)
          ?.map((e) => WorldStat.fromJson(e as Map<String, dynamic>))
          .toList(),
      defaultPlayerStats:
          (json['defaultPlayerStats'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as int),
      ),
      npcs: (json['npcs'] as List<dynamic>?)
          ?.map((e) => Npc.fromJson(e as Map<String, dynamic>))
          .toList(),
      audioBusses: (json['audioBusses'] as List<dynamic>?)
          ?.map((e) => AudioBus.fromJson(e as Map<String, dynamic>))
          .toList(),
      defaultCommandTriggers: (json['defaultCommandTriggers'] as List<dynamic>?)
          ?.map((e) => CommandTrigger.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WorldToJson(World instance) => <String, dynamic>{
      'title': instance.title,
      'globalOptions': instance.globalOptions,
      'soundOptions': instance.soundOptions,
      'mainMenuOptions': instance.mainMenuOptions,
      'credits': instance.credits,
      'creditsMenuOptions': instance.creditsMenuOptions,
      'soundMenuOptions': instance.soundMenuOptions,
      'creditsAssets': instance.creditsAssets,
      'musicAssets': instance.musicAssets,
      'interfaceSoundsAssets': instance.interfaceSoundsAssets,
      'equipmentAssets': instance.equipmentAssets,
      'terrainAssets': instance.terrainAssets,
      'ambianceAssets': instance.ambianceAssets,
      'conversationAssets': instance.conversationAssets,
      'questAssets': instance.questAssets,
      'directions': instance.directions,
      'equipmentPositions': instance.equipmentPositions,
      'terrains': instance.terrains,
      'zones': instance.zones,
      'pauseMenuOptions': instance.pauseMenuOptions,
      'reverbs': instance.reverbs,
      'commandCategories': instance.commandCategories,
      'defaultPlayerPreferences': instance.defaultPlayerPreferences,
      'conversationCategories': instance.conversationCategories,
      'quests': instance.quests,
      'questMenuOptions': instance.questMenuOptions,
      'scenes': instance.scenes,
      'stats': instance.stats,
      'defaultPlayerStats': instance.defaultPlayerStats,
      'npcs': instance.npcs,
      'audioBusses': instance.audioBusses,
      'defaultCommandTriggers': instance.defaultCommandTriggers,
    };
