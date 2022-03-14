/// Provides the [QuestCondition] class.
import 'package:json_annotation/json_annotation.dart';

import '../quests/quest.dart';
import '../quests/quest_stage.dart';

part 'quest_condition.g.dart';

/// The condition of a particular quest.
@JsonSerializable()
class QuestCondition {
  /// Create an instance.
  QuestCondition({
    required this.questId,
    required this.stageId,
  });

  /// Create an instance from a JSON object.
  factory QuestCondition.fromJson(Map<String, dynamic> json) =>
      _$QuestConditionFromJson(json);

  /// The ID of the [Quest].
  String questId;

  /// The ID of the [QuestStage].
  ///
  /// If this value is `null`, then the quest must have not been started.
  String? stageId;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$QuestConditionToJson(this);
}
