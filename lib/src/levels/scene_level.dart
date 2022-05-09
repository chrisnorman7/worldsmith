import 'package:ziggurat/levels.dart';
import 'package:ziggurat/sound.dart';
import 'package:ziggurat/ziggurat.dart';

import '../../command_triggers.dart';
import '../../util.dart';
import '../../world_context.dart';
import '../json/commands/call_command.dart';
import '../json/scenes/scene.dart';
import '../json/scenes/scene_section.dart';

/// A level for showing a scene.
class SceneLevel extends Level {
  /// Create an instance.
  SceneLevel({
    required this.worldContext,
    required this.scene,
    this.callCommand,
    this.index = 0,
  }) : super(
          game: worldContext.game,
        ) {
    registerCommand(
      nextSceneSectionCommandTrigger.name,
      Command(
        onStart: showNextSection,
      ),
    );
    for (final worldCommand in worldContext.world.customCommandTriggers
        .where((final element) => element.scenes == true)) {
      registerCommand(
        worldCommand.commandTrigger.name,
        worldCommand.getCommand(worldContext),
      );
    }
  }

  /// The world context to use.
  final WorldContext worldContext;

  /// The scene to show.
  final Scene scene;

  /// The command to run when all the [SceneSection]s have been shown.
  final CallCommand? callCommand;

  /// The current index in the [scene] sections.
  int index;

  /// The reverb to use.
  CreateReverb? _reverb;

  /// The sound channel to play through.
  SoundChannel? _soundChannel;

  /// The currently-playing sound.
  PlaySound? sound;

  /// Show the next section.
  void showNextSection() {
    if (index >= scene.sections.length) {
      // The scene is over.
      game.popLevel();
      final command = callCommand;
      if (command != null) {
        worldContext.handleCallCommand(callCommand: command);
      }
    } else {
      final section = scene.sections[index];
      index++;
      final reverbId = scene.reverbId;
      final world = worldContext.world;
      if (_reverb == null && reverbId != null) {
        final preset = world.getReverb(reverbId);
        _reverb = game.createReverb(preset);
      }
      var soundChannel = _soundChannel;
      if (soundChannel == null) {
        soundChannel = game.createSoundChannel(
          gain: worldContext.playerPreferences.interfaceSoundsGain,
          reverb: _reverb,
        );
        _soundChannel = soundChannel;
      }
      final sectionSound = section.sound;
      final message = worldContext.getCustomMessage(
        message: section.text,
        keepAlive: true,
        gain: sectionSound?.gain,
        sound: sectionSound == null
            ? null
            : getAssetReferenceReference(
                assets: world.interfaceSoundsAssets,
                id: sectionSound.id,
              ).reference,
      );
      sound = game.outputMessage(
        message,
        oldSound: sound,
        soundChannel: soundChannel,
      );
    }
  }

  /// Show the next section.
  @override
  void onPush() {
    super.onPush();
    showNextSection();
  }

  /// Destroy everything.
  @override
  void onPop(final double? fadeLength) {
    super.onPop(fadeLength);
    _reverb?.destroy();
    _reverb = null;
    _soundChannel?.destroy();
    _soundChannel = null;
    sound?.destroy();
    sound = null;
  }
}
