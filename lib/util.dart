/// Provides utility functions.
import 'dart:math';

import 'package:path/path.dart' as path;
import 'package:ziggurat/sound.dart';
import 'package:ziggurat_sounds/ziggurat_sounds.dart';

import 'constants.dart';
import 'src/json/sound.dart';
import 'src/json/world.dart';

/// Return the asset reference with the given [id].
AssetReferenceReference? getAssetReferenceReference({
  required AssetList assets,
  required String? id,
}) {
  if (id == null) {
    return null;
  }
  return assets.firstWhere(
    (element) => element.variableName == id,
  );
}

/// Get an ambiance from the given [sound].
Ambiance? getAmbiance({
  required AssetList assets,
  required Sound? sound,
  Point<double>? position,
}) {
  if (sound == null) {
    return null;
  }
  final asset =
      getAssetReferenceReference(assets: assets, id: sound.id)!.reference;
  return Ambiance(sound: asset, gain: sound.gain, position: position);
}

/// Play the given [sound] through the given [channel].
PlaySound playSound(
        {required SoundChannel channel,
        required Sound sound,
        required AssetList assets,
        bool keepAlive = false,
        bool looping = false}) =>
    channel.playSound(
      getAssetReferenceReference(assets: assets, id: sound.id)!.reference,
      gain: sound.gain,
      keepAlive: keepAlive,
      looping: looping,
    );

/// Returns an asset store.
AssetStore getAssetStore({
  required String name,
  required AssetList assets,
  required String comment,
}) =>
    AssetStore(
        filename: path.join(assetsDirectory, '$name.dart'),
        destination: path.join(assetsDirectory, name),
        assets: assets,
        comment: comment);
