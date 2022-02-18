import 'package:json_annotation/json_annotation.dart';
import 'package:ziggurat_sounds/ziggurat_sounds.dart';

import '../sound.dart';

part 'custom_sound.g.dart';

/// The [AssetStore] where a [CustomSound] should get its sound from.
enum CustomSoundAssetStore {
  /// Credits asset store.
  credits,

  /// The equipment asset store.
  equipment,

  /// The interface sounds asset store.
  interface,

  /// The music asset store.
  music,

  /// The terrains asset store.
  terrain,
}

/// A sound from any asset store.
@JsonSerializable()
class CustomSound extends Sound {
  /// Create an instance.
  CustomSound({
    required this.assetStore,
    required String id,
    double gain = 0.7,
  }) : super(id: id, gain: gain);

  /// Create an instance from a JSON object.
  factory CustomSound.fromJson(Map<String, dynamic> json) =>
      _$CustomSoundFromJson(json);

  /// The asset store where [id] resides.
  CustomSoundAssetStore assetStore;

  /// Convert an instance to JSON.
  @override
  Map<String, dynamic> toJson() => _$CustomSoundToJson(this);
}
