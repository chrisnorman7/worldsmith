/// Provides the [QuestMenuOptions] class.
import 'package:json_annotation/json_annotation.dart';

part 'quest_menu_options.g.dart';

/// The options for the quest menu.
@JsonSerializable()
class QuestMenuOptions {
  /// Create an instance.
  QuestMenuOptions({
    this.title = 'Quests',
    this.noQuestsMessage = "You haven't started any quests",
  });

  /// Create an instance from a JSON object.
  factory QuestMenuOptions.fromJson(final Map<String, dynamic> json) =>
      _$QuestMenuOptionsFromJson(json);

  /// The title of this menu.
  String title;

  /// The message for when there are no quests to show.
  String noQuestsMessage;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$QuestMenuOptionsToJson(this);
}
