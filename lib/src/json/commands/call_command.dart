import 'package:json_annotation/json_annotation.dart';

part 'call_command.g.dart';

/// The instruction to call another command with the given [commandId].
@JsonSerializable()
class CallCommand {
  /// Create an instance.
  CallCommand({required this.commandId, this.callAfter});

  /// Create an instance from a JSON object.
  factory CallCommand.fromJson(Map<String, dynamic> json) =>
      _$CallCommandFromJson(json);

  /// The ID of the command to call.
  String commandId;

  /// How many milliseconds should the game wait before calling the command.
  int? callAfter;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$CallCommandToJson(this);
}
