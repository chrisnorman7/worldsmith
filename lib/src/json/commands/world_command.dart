import 'package:json_annotation/json_annotation.dart';

import '../../../world_context.dart';
import '../../level/walking_mode.dart';
import '../conversation/start_conversation.dart';
import '../messages/custom_message.dart';
import 'call_command.dart';
import 'local_teleport.dart';
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
    this.callCommand,
    this.startConversation,
  }) : message = message ?? CustomMessage();

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
  CallCommand? callCommand;

  /// Start a conversation.
  StartConversation? startConversation;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$WorldCommandToJson(this);
}
