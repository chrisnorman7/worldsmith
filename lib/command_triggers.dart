/// Provides the commands that will be used by a generated game.
import 'package:dart_sdl/dart_sdl.dart';
import 'package:ziggurat/ziggurat.dart';

/// Walk forwards, fast.
const walkFastForwardsCommandTrigger = CommandTrigger(
  name: 'walk_forwards_fast',
  description: 'Walk forwards',
  button: GameControllerButton.dpadUp,
  keyboardKey: CommandKeyboardKey(ScanCode.SCANCODE_W),
);

/// Walk backwards, fast.
const walkFastBackwardsCommandTrigger = CommandTrigger(
  name: 'walk_backwards_fast',
  description: 'Walk backwards',
  button: GameControllerButton.dpadDown,
  keyboardKey: CommandKeyboardKey(ScanCode.SCANCODE_S),
);

/// Walk forwards, slowly.
const walkSlowForwardsCommandTrigger = CommandTrigger(
  name: 'walk_forwards_slow',
  description: 'Walk forwards slowly',
  keyboardKey: CommandKeyboardKey(ScanCode.SCANCODE_W, altKey: true),
);

/// Walk backwards, slowly.
const walkSlowBackwardsCommandTrigger = CommandTrigger(
  name: 'walk_backwards_slow',
  description: 'Walk backwards slowly',
  keyboardKey: CommandKeyboardKey(ScanCode.SCANCODE_S, altKey: true),
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
  description: 'Turn left 45 degrees',
  button: GameControllerButton.a,
  keyboardKey: CommandKeyboardKey(ScanCode.SCANCODE_LEFT),
);

/// Turn right.
const turnRightCommandTrigger = CommandTrigger(
  name: 'turn_right',
  description: 'Turn right 45 degrees',
  button: GameControllerButton.y,
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

/// The default trigger map.
const defaultTriggerMap = TriggerMap(
  [
    walkSlowForwardsCommandTrigger,
    walkSlowBackwardsCommandTrigger,
    walkFastForwardsCommandTrigger,
    walkFastBackwardsCommandTrigger,
    sidestepLeftCommandTrigger,
    sidestepRightCommandTrigger,
    turnLeftCommandTrigger,
    turnRightCommandTrigger,
    pauseMenuCommandTrigger,
    showCoordinatesCommandTrigger,
    showFacingCommandTrigger,
  ],
);
