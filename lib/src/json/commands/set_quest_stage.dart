/// Provides the [SetQuestStage] class.
import 'package:json_annotation/json_annotation.dart';

part 'set_quest_stage.g.dart';

/// An instruction to set a quest stage.
@JsonSerializable()
class SetQuestStage {
  /// Create an instance.
  const SetQuestStage({
    required this.questId,
    required this.stageId,
  });

  /// Create an instance from a JSON object.
  factory SetQuestStage.fromJson(Map<String, dynamic> json) =>
      _$SetQuestStageFromJson(json);

  /// The ID of the quest.
  final String questId;

  /// The ID of the stage within the quest.
  ///
  /// If this value is `null`, then any stage that has already been attained
  /// will be cleared.
  final String? stageId;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$SetQuestStageToJson(this);
}
