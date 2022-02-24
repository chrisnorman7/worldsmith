import 'package:json_annotation/json_annotation.dart';

part 'call_command.g.dart';

/// The instruction to call another command with the given [commandId].
@JsonSerializable()
class CallCommand {
  /// Create an instance.
  CallCommand({
    required this.commandId,
    this.callAfter,
    this.chance = 1,
  }) : assert(
          chance >= 1,
          'The `chance` value must be no less than 1.',
        );

  /// Create an instance from a JSON object.
  factory CallCommand.fromJson(Map<String, dynamic> json) =>
      _$CallCommandFromJson(json);

  /// The ID of the command to call.
  String commandId;

  /// How many milliseconds should the game wait before calling the command.
  int? callAfter;

  /// The random number to generate to figure out if this command should run.
  ///
  /// If this value is `1`, then the command will always run. Otherwise, there
  /// will be a 1 in [chance] chance of it running.
  int chance;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$CallCommandToJson(this);
}
