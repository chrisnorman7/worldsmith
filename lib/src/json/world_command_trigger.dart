/// Provides the [WorldCommandTrigger] class.
import 'package:json_annotation/json_annotation.dart';
import 'package:ziggurat/ziggurat.dart';

import '../../world_context.dart';
import '../levels/zone_level.dart';
import 'commands/call_command.dart';

part 'world_command_trigger.g.dart';

/// A command trigger that can be created by a game builder.
///
/// Instances of this class can be used in various places, depending on the
/// various boolean properties.
@JsonSerializable()
class WorldCommandTrigger {
  /// Create an instance.
  WorldCommandTrigger({
    required this.commandTrigger,
    this.startCommand,
    this.stopCommand,
    this.interval,
    this.zone = true,
    this.mainMenu = false,
    this.lookAroundMenu = false,
    this.pauseMenu = false,
    this.soundOptionsMenu = false,
    this.zoneOverview = false,
    this.scenes = false,
  });

  /// Create an instance from a JSON object.
  factory WorldCommandTrigger.fromJson(final Map<String, dynamic> json) =>
      _$WorldCommandTriggerFromJson(json);

  /// The command trigger to use.
  CommandTrigger commandTrigger;

  /// The command to run when this trigger is used.
  CallCommand? startCommand;

  /// The command to call when this trigger is released.
  CallCommand? stopCommand;

  /// How often this command can fire.
  ///
  /// To see what this value is used for, look at the [Command.interval]
  /// property.
  int? interval;

  /// Whether this command can be used in zones.
  bool zone;

  /// Whether this command can be used in the main menu.
  bool mainMenu;

  /// Whether this command can be used in the pause menu.
  bool pauseMenu;

  /// Whether this command can be used in the look around menu.
  bool lookAroundMenu;

  /// Whether this command can be used in the zone overview.
  bool zoneOverview;

  /// Whether this command can be used in the sound options menu.
  bool soundOptionsMenu;

  /// Whether this command can be used in scenes.
  bool scenes;

  /// Call the given [callCommand] with the given [worldContext].
  ///
  /// If [callCommand] is `null`, this method does nothing.
  void callCommand({
    required final WorldContext worldContext,
    required final CallCommand? callCommand,
  }) {
    if (callCommand == null) {
      return;
    }
    final level = worldContext.game.currentLevel;
    worldContext.handleCallCommand(
      callCommand: callCommand,
      zoneLevel: level is ZoneLevel ? level : null,
    );
  }

  /// Get a command that can be registered to run this instance.
  Command getCommand(final WorldContext worldContext) => Command(
        interval: interval,
        onStart: () => callCommand(
          worldContext: worldContext,
          callCommand: startCommand,
        ),
        onStop: () => callCommand(
          worldContext: worldContext,
          callCommand: stopCommand,
        ),
      );

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$WorldCommandTriggerToJson(this);
}
