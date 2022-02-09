/// Functions related to [Menu]s.
import 'package:ziggurat/menus.dart';
import 'package:ziggurat/ziggurat.dart';

import '../../extensions.dart';
import '../json/world.dart';

/// Make a message suitable for a [MenuItem] label.
Message makeMenuItemMessage(World world, {String? text}) =>
    world.interfaceSoundsAssetStore.getMessage(
      keepAlive: true,
      sound: world.soundOptions.menuMoveSound,
      text: text,
    );

/// Make a button with the proper activate sound.
Button makeButton(World world, TaskFunction func) => Button(
      func,
      activateSound: world.interfaceSoundsAssetStore
          .getAssetReferenceFromVariableName(
              world.soundOptions.menuActivateSound?.id),
    );
