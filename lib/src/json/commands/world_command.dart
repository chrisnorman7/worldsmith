import 'package:json_annotation/json_annotation.dart';

import '../../../world_context.dart';
import '../../level/walking_mode.dart';
import '../conversations/start_conversation.dart';
import '../messages/custom_message.dart';
import '../scenes/show_scene.dart';
import 'call_command.dart';
import 'local_teleport.dart';
import 'return_to_main_menu.dart';
import 'set_quest_stage.dart';
import 'zone_teleport.dart';

part 'world_command.g.dart';

/// A command to make stuff happen in the world.
@JsonSerializable()
class WorldCommand {
  /// Create an instance.
  WorldCommand({
    required this.id,
    required this.name,
    CustomMessage? message,
    this.localTeleport,
    this.zoneTeleport,
    this.walkingMode,
    this.customCommandName,
    List<CallCommand>? callCommands,
    this.startConversation,
    this.setQuestStage,
    this.returnToMainMenu,
    this.showScene,
  })  : message = message ?? CustomMessage(),
        callCommands = callCommands ?? [];

  /// Create an instance from a JSON object.
  factory WorldCommand.fromJson(Map<String, dynamic> json) =>
      _$WorldCommandFromJson(json);

  /// The ID of this command.
  final String id;

  /// The name of this command.
  String name;

  /// A message to show.
  final CustomMessage message;

  /// Teleport somewhere in the current zone.
  LocalTeleport? localTeleport;

  /// Teleport to another zone.
  ZoneTeleport? zoneTeleport;

  /// Set a new walking mode.
  WalkingMode? walkingMode;

  /// The name of a custom command to call.
  ///
  /// This name must be a key in the [WorldContext.customCommands] map.
  String? customCommandName;

  /// Call another command.
  List<CallCommand> callCommands;

  /// Start a conversation.
  StartConversation? startConversation;

  /// Set a stage in a quest.
  SetQuestStage? setQuestStage;

  /// Return to the main menu.
  ReturnToMainMenu? returnToMainMenu;

  /// Show a scene.
  ShowScene? showScene;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$WorldCommandToJson(this);
}
