import 'package:json_annotation/json_annotation.dart';
import 'package:ziggurat/sound.dart';

import 'quests/quest.dart';

part 'player_preferences.g.dart';

/// The preferences for the player.
@JsonSerializable()
class PlayerPreferences {
  /// Create an instance.
  PlayerPreferences({
    this.interfaceSoundsGain = 0.7,
    this.musicGain = 0.7,
    this.ambianceGain = 0.7,
    this.pannerStrategy = DefaultPannerStrategy.stereo,
    this.turnSensitivity = 3,
    Map<String, String>? questStages,
  }) : questStages = questStages ?? {};

  /// Create an instance from a JSON object.
  factory PlayerPreferences.fromJson(Map<String, dynamic> json) =>
      _$PlayerPreferencesFromJson(json);

  /// The gain for the interface sounds.
  double interfaceSoundsGain;

  /// The gain for game music.
  double musicGain;

  /// The gain for ambiance sounds.
  double ambianceGain;

  /// The panning strategy to use.
  DefaultPannerStrategy pannerStrategy;

  /// The turn modifier.
  ///
  /// This value will be multiplied by the amount the game controller stick is
  /// pushed.
  int turnSensitivity;

  /// The current stages of all [Quest]s the player has embarked upon.
  final Map<String, String> questStages;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$PlayerPreferencesToJson(this);
}
