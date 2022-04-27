/// Provides utility functions.
import 'dart:math';

import 'package:path/path.dart' as path;
import 'package:ziggurat/sound.dart';
import 'package:ziggurat_sounds/ziggurat_sounds.dart';

import 'constants.dart';
import 'src/json/sounds/sound.dart';
import 'src/json/world.dart';

/// Return the asset reference with the given [id].
AssetReferenceReference getAssetReferenceReference({
  required final AssetList assets,
  required final String id,
}) =>
    assets.firstWhere(
      (final element) => element.variableName == id,
    );

/// Get an ambiance from the given [sound].
Ambiance getAmbiance({
  required final AssetList assets,
  required final Sound sound,
  final Point<double>? position,
}) {
  final reference = getAssetReferenceReference(assets: assets, id: sound.id);
  return Ambiance(
    sound: reference.reference,
    gain: sound.gain,
    position: position,
  );
}

/// Get an ambiance from the given [sound].
Music? getMusic({
  required final AssetList assets,
  required final Sound? sound,
}) {
  if (sound == null) {
    return null;
  }
  final reference = getAssetReferenceReference(assets: assets, id: sound.id);
  return Music(
    sound: reference.reference,
    gain: sound.gain,
  );
}

/// Play the given [sound] through the given [channel].
PlaySound playSound({
  required final SoundChannel channel,
  required final Sound sound,
  required final AssetList assets,
  final bool keepAlive = false,
  final bool looping = false,
}) =>
    channel.playSound(
      getAssetReferenceReference(assets: assets, id: sound.id).reference,
      gain: sound.gain,
      keepAlive: keepAlive,
      looping: looping,
    );

/// Returns an asset store.
AssetStore getAssetStore({
  required final String name,
  required final AssetList assets,
  required final String comment,
}) =>
    AssetStore(
      filename: path.join(assetsDirectory, '$name.dart'),
      destination: path.join(assetsDirectory, name),
      assets: assets,
      comment: comment,
    );
