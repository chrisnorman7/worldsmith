import 'package:test/test.dart';
import 'package:worldsmith/worldsmith.dart';

void main() {
  group(
    'CustomSound class',
    () {
      final sound = CustomSound(
        assetStore: CustomSoundAssetStore.music,
        id: 'main_menu_music',
      );
      test(
        '.toJson',
        () {
          final json = sound.toJson();
          expect(json['assetStore'], sound.assetStore.name);
          expect(json['gain'], sound.gain);
          expect(json['id'], sound.id);
        },
      );
    },
  );
}
