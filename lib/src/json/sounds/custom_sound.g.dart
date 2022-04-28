// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_sound.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomSound _$CustomSoundFromJson(Map<String, dynamic> json) => CustomSound(
      assetStore:
          $enumDecode(_$CustomSoundAssetStoreEnumMap, json['assetStore']),
      id: json['id'] as String,
      gain: (json['gain'] as num?)?.toDouble() ?? 0.7,
    )..audioBusId = json['audioBusId'] as String?;

Map<String, dynamic> _$CustomSoundToJson(CustomSound instance) =>
    <String, dynamic>{
      'id': instance.id,
      'gain': instance.gain,
      'assetStore': _$CustomSoundAssetStoreEnumMap[instance.assetStore],
      'audioBusId': instance.audioBusId,
    };

const _$CustomSoundAssetStoreEnumMap = {
  CustomSoundAssetStore.ambiances: 'ambiances',
  CustomSoundAssetStore.conversations: 'conversations',
  CustomSoundAssetStore.credits: 'credits',
  CustomSoundAssetStore.equipment: 'equipment',
  CustomSoundAssetStore.interface: 'interface',
  CustomSoundAssetStore.music: 'music',
  CustomSoundAssetStore.quest: 'quest',
  CustomSoundAssetStore.terrain: 'terrain',
};
