/// Provides various extensions used by the package.
library extensions;

import 'dart:math';

import 'package:ziggurat/sound.dart';
import 'package:ziggurat/ziggurat.dart';
import 'package:ziggurat_sounds/ziggurat_sounds.dart';

import 'constants.dart';
import 'src/json/sound.dart';

/// Extension methods on asset stores.
extension WorldSmithAssetStoreExtensionMethods on AssetStore {
  /// Returns the asset whose [AssetReferenceReference] has the given
  /// [variableName].
  AssetReference? getAssetReferenceFromVariableName(String? variableName) {
    if (variableName == null) {
      return null;
    }
    return assets
        .firstWhere((element) => element.variableName == variableName)
        .reference;
  }

  /// Make a message with a sound.
  ///
  /// The id of the given [sound] must reside within this asset store.
  Message getMessage({
    String? text,
    Sound? sound,
    bool keepAlive = false,
  }) {
    final asset = getAssetReferenceFromVariableName(sound?.id);
    return Message(
      gain: sound?.gain ?? defaultGain,
      keepAlive: keepAlive,
      sound: asset,
      text: text,
    );
  }

  /// Make an ambiance from the given [sound].
  ///
  /// The ID of the sound must reside in this asset store.
  Ambiance getAmbiance(Sound sound, {Point<double>? position}) {
    final asset = getAssetReferenceFromVariableName(sound.id)!;
    return Ambiance(sound: asset, gain: sound.gain, position: position);
  }
}
