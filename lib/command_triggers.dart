/// Provides the commands that will be used by a generated game.
import 'package:dart_sdl/dart_sdl.dart';
import 'package:ziggurat/ziggurat.dart';

/// Toggle slow walk.
const slowWalkCommandTrigger = CommandTrigger(
  name: 'slow_walk',
  description: 'Toggle walking slowly',
  keyboardKey: CommandKeyboardKey(ScanCode.SCANCODE_LALT),
);

/// Walk forwards.
const walkForwardsCommandTrigger = CommandTrigger(
  name: 'walk_forwards',
  description: 'Walk forwards',
  button: GameControllerButton.dpadUp,
  keyboardKey: CommandKeyboardKey(ScanCode.SCANCODE_W),
);

/// Walk backwards.
const walkBackwardsCommandTrigger = CommandTrigger(
  name: 'walk_backwards',
  description: 'Walk backwards',
  button: GameControllerButton.dpadDown,
  keyboardKey: CommandKeyboardKey(ScanCode.SCANCODE_S),
);

/// Sidestep left.
const sidestepLeftCommandTrigger = CommandTrigger(
  name: 'sidestep_left',
  description: 'Sidestep left',
  button: GameControllerButton.dpadLeft,
  keyboardKey: CommandKeyboardKey(ScanCode.SCANCODE_A),
);

/// Sidestep right.
const sidestepRightCommandTrigger = CommandTrigger(
  name: 'sidestep_right',
  description: 'Sidestep right',
  button: GameControllerButton.dpadRight,
  keyboardKey: CommandKeyboardKey(ScanCode.SCANCODE_D),
);

/// Turn left.
const turnLeftCommandTrigger = CommandTrigger(
  name: 'turn_left',
  description: 'Turn left a bit',
  keyboardKey: CommandKeyboardKey(ScanCode.SCANCODE_LEFT),
);

/// Turn right.
const turnRightCommandTrigger = CommandTrigger(
  name: 'turn_right',
  description: 'Turn right',
  keyboardKey: CommandKeyboardKey(ScanCode.SCANCODE_RIGHT),
);

/// Bring up the pause menu.
const pauseMenuCommandTrigger = CommandTrigger(
  name: 'pause',
  description: 'Pause menu',
  button: GameControllerButton.start,
  keyboardKey: CommandKeyboardKey(ScanCode.SCANCODE_ESCAPE),
);

/// Show coordinates.
const showCoordinatesCommandTrigger = CommandTrigger(
  name: 'show_coordinates',
  description: 'Show coordinates',
  button: GameControllerButton.x,
  keyboardKey: CommandKeyboardKey(ScanCode.SCANCODE_C),
);

/// Show facing.
const showFacingCommandTrigger = CommandTrigger(
  name: 'show_facing',
  description: 'Show direction of travel',
  button: GameControllerButton.b,
  keyboardKey: CommandKeyboardKey(ScanCode.SCANCODE_F),
);

/// Switch to the next menu.
const switchMenuForwardCommandTrigger = CommandTrigger(
  name: 'switch_menu_forward',
  description: 'Move to the next menu',
  button: GameControllerButton.b,
  keyboardKey: CommandKeyboardKey(ScanCode.SCANCODE_TAB),
);

/// Switch to the previous menu.
const switchMenuBackwardsCommandTrigger = CommandTrigger(
  name: 'switch_menu_backwards',
  description: 'Go to the previous menu',
  button: GameControllerButton.x,
  keyboardKey: CommandKeyboardKey(
    ScanCode.SCANCODE_TAB,
    shiftKey: true,
  ),
);

/// The default trigger map.
final defaultTriggerMap = TriggerMap(
  [
    slowWalkCommandTrigger,
    walkForwardsCommandTrigger,
    walkBackwardsCommandTrigger,
    sidestepLeftCommandTrigger,
    sidestepRightCommandTrigger,
    turnLeftCommandTrigger,
    turnRightCommandTrigger,
    pauseMenuCommandTrigger,
    showCoordinatesCommandTrigger,
    showFacingCommandTrigger,
    switchMenuForwardCommandTrigger,
    switchMenuBackwardsCommandTrigger,
  ],
);
