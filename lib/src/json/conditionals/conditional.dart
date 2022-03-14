/// Provides the [Conditional] class.
import 'package:json_annotation/json_annotation.dart';

import '../commands/world_command.dart';
import '../conversations/conversation.dart';
import '../conversations/conversation_response.dart';
import 'quest_condition.dart';

part 'conditional.g.dart';

/// A set of conditions which must be satisfied.
///
/// Instances of this class are used by the [WorldCommand] class to decide if
/// commands should run, and the [Conversation] class to decide whether a
/// particular [ConversationResponse] should be visible.
///
/// A condition will only pass if every check passes.
@JsonSerializable()
class Conditional {
  /// Create an instance.
  Conditional({
    this.questCondition,
    this.chance = 1,
    this.conditionFunctionName,
  }) : assert(
          chance >= 1,
          'The `chance` value must be no less than 1.',
        );

  /// Create an instance from a JSON object.
  factory Conditional.fromJson(Map<String, dynamic> json) =>
      _$ConditionalFromJson(json);

  /// The condition of a particular quest.
  QuestCondition? questCondition;

  /// The random number to generate to figure out if this command should run.
  ///
  /// If this value is `1`, then the command will always run. Otherwise, there
  /// will be a 1 in [chance] chance of it running.
  int chance;

  /// The name of a custom condition function to run.
  String? conditionFunctionName;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$ConditionalToJson(this);
}
