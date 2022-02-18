import 'package:test/test.dart';
import 'package:worldsmith/world_context.dart';
import 'package:worldsmith/worldsmith.dart';
import 'package:ziggurat/menus.dart';
import 'package:ziggurat/ziggurat.dart';
import 'package:ziggurat_sounds/ziggurat_sounds.dart';

void main() {
  group(
    'CreditsMenu class',
    () {
      final zigguratSound = AssetReferenceReference(
        variableName: 'ziggurat_sound',
        reference: AssetReference.file('ziggurat.mp3'),
      );
      final zigguratCredit = WorldCredit(
        id: 'ziggurat',
        title: 'Chris Norman: Ziggurat',
        sound: Sound(id: zigguratSound.variableName, gain: 1.0),
        url: 'https://pub.dev/packages/ziggurat',
      );
      final synthizerSound = AssetReferenceReference(
        variableName: 'synthizer_sound',
        reference: AssetReference.file('synthizer.mp3'),
      );
      final synthizerCredit = WorldCredit(
        id: 'synthizer',
        title: 'Austin Hicks: Synthizer',
        sound: Sound(id: synthizerSound.variableName, gain: 2.0),
        url: 'https://synthizer.github.io/',
      );
      final otherCredit = WorldCredit(id: 'other_credit', title: 'Many Others');
      final creditsMusic = AssetReferenceReference(
        variableName: 'credits_music',
        reference: AssetReference.file('credits_music.mp3'),
      );
      final moveSound = AssetReferenceReference(
          variableName: 'move_sound',
          reference: AssetReference.file('menu_move.mp3'));
      final world = World(
        title: 'World With Credits',
        credits: [synthizerCredit, zigguratCredit, otherCredit],
        creditsAssets: [synthizerSound, zigguratSound],
        creditsMenuOptions: CreditsMenuOptions(
          music: Sound(id: creditsMusic.variableName, gain: 3.0),
        ),
        interfaceSoundsAssets: [moveSound],
        musicAssets: [creditsMusic],
        soundOptions: SoundOptions(
            menuMoveSound: Sound(id: moveSound.variableName, gain: 4.0)),
      );
      final game = Game(world.title);
      final worldContext = WorldContext(game: game, world: world);
      final creditsMenu = worldContext.creditsMenuBuilder(worldContext);
      test(
        'Initialisation',
        () {
          expect(creditsMenu, isA<CreditsMenu>());
          expect(creditsMenu.menuItems.length, 3);
          final synthizerMenuItem = creditsMenu.menuItems.first;
          expect(synthizerMenuItem.label.gain, synthizerCredit.sound?.gain);
          expect(synthizerMenuItem.label.keepAlive, isTrue);
          expect(synthizerMenuItem.label.sound, synthizerSound.reference);
          expect(synthizerMenuItem.label.text, synthizerCredit.title);
          expect(synthizerMenuItem.widget, isA<Button>());
          final zigguratMenuItem = creditsMenu.menuItems[1];
          expect(zigguratMenuItem.label.gain, zigguratCredit.sound?.gain);
          expect(zigguratMenuItem.label.keepAlive, isTrue);
          expect(zigguratMenuItem.label.sound, zigguratSound.reference);
          expect(zigguratMenuItem.label.text, zigguratCredit.title);
          expect(zigguratMenuItem.widget, isA<Button>());
          final otherMenuItem = creditsMenu.menuItems.last;
          expect(otherMenuItem.label.gain, 4.0);
          expect(otherMenuItem.label.keepAlive, isTrue);
          expect(otherMenuItem.label.sound, moveSound.reference);
          expect(otherMenuItem.label.text, otherCredit.title);
          expect(otherMenuItem.widget, menuItemLabel);
        },
      );
    },
  );
}
