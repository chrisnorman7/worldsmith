/// Provides various extensions used by the package.
library extensions;

import 'package:ziggurat/ziggurat.dart';
import 'package:ziggurat_sounds/ziggurat_sounds.dart';

/// Extension methods on asset stores.
extension WorldSmithAssetStoreExtensionMethods on AssetStore {
  /// Returns the asset whose [AssetReferenceReference] has the given
  /// [variableName].
  AssetReference getAssetReferenceFromVariableName(String variableName) =>
      assets
          .firstWhere((element) => element.variableName == variableName)
          .reference;
}
