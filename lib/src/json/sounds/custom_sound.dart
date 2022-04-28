// ignore_for_file: prefer_final_parameters
import 'package:json_annotation/json_annotation.dart';
import 'package:ziggurat_sounds/ziggurat_sounds.dart';

import 'audio_bus.dart';
import 'sound.dart';

part 'custom_sound.g.dart';

/// The [AssetStore] where a [CustomSound] should get its sound from.
enum CustomSoundAssetStore {
  /// Ambiances asset store.
  ambiances,

  /// Conversations asset store.
  conversations,

  /// Credits asset store.
  credits,

  /// The equipment asset store.
  equipment,

  /// The interface sounds asset store.
  interface,

  /// The music asset store.
  music,

  /// The quests asset store.
  quest,

  /// The terrains asset store.
  terrain,
}

/// A sound from any asset store.
@JsonSerializable()
class CustomSound extends Sound {
  /// Create an instance.
  CustomSound({
    required this.assetStore,
    required super.id,
    super.gain,
  });

  /// Create an instance from a JSON object.
  factory CustomSound.fromJson(final Map<String, dynamic> json) =>
      _$CustomSoundFromJson(json);

  /// The asset store where [id] resides.
  CustomSoundAssetStore assetStore;

  /// The ID of the [AudioBus] to play through.
  ///
  /// If this value is `null`, then the interface sounds sound channel will be
  /// used.
  String? audioBusId;

  /// Convert an instance to JSON.
  @override
  Map<String, dynamic> toJson() => _$CustomSoundToJson(this);
}
