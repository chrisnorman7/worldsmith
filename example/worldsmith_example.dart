import 'package:path/path.dart' as path;
import 'package:worldsmith/functions.dart';
import 'package:worldsmith/worldsmith.dart';
import 'package:ziggurat_sounds/ziggurat_sounds.dart';

const _assetStoreDirectory = 'asset_stores';
Future<void> main() {
  final world = World(
    title: 'Example World',
    options: WorldOptions(),
    credits: [
      WorldCredit(
        title: 'Ziggurat',
        url: 'https://github.com/chrisnorman7/ziggurat',
      )
    ],
    creditsAssetStore: AssetStore(
      filename: path.join(_assetStoreDirectory, 'credits.json'),
      destination: path.join(
        _assetStoreDirectory,
        'credits',
      ),
    ),
    musicAssetStore: AssetStore(
      filename: path.join(_assetStoreDirectory, 'music.json'),
      destination: path.join(_assetStoreDirectory, 'music'),
    ),
    interfaceSoundsAssetStore: AssetStore(
      filename: path.join(_assetStoreDirectory, 'interface.json'),
      destination: path.join(_assetStoreDirectory, 'interface'),
    ),
  );
  return runWorld(world);
}
