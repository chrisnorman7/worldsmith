/// Functions related to [Menu]s.
import 'package:ziggurat/menus.dart';
import 'package:ziggurat/ziggurat.dart';

import '../../util.dart';
import '../json/sound.dart';
import '../json/world.dart';

/// Make a message suitable for a [MenuItem] label.
Message makeMenuItemMessage(World world, {String? text}) => Message(
      gain: world.soundOptions.menuMoveSound?.gain ??
          world.soundOptions.defaultGain,
      keepAlive: true,
      sound: world.menuMoveSound,
      text: text,
    );

/// Make a message with the given [sound].
Message makeSoundMessage({
  required Sound sound,
  required AssetList assets,
  required String? text,
  bool keepAlive = false,
}) =>
    Message(
      gain: sound.gain,
      keepAlive: keepAlive,
      sound: getAssetReferenceReference(
        assets: assets,
        id: sound.id,
      )?.reference,
      text: text,
    );

/// Make a button with the proper activate sound.
Button makeButton(World world, TaskFunction func) =>
    Button(func, activateSound: world.menuActivateSound);
