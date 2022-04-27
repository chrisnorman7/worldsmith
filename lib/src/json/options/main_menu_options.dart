/// Provides the [MainMenuOptions] class.
import 'package:json_annotation/json_annotation.dart';

import '../sounds/sound.dart';

part 'main_menu_options.g.dart';

/// The options for the main menu.
@JsonSerializable()
class MainMenuOptions {
  /// Create an instance.
  MainMenuOptions({
    this.title = 'Main Menu',
    this.music,
    this.fadeTime = 4.0,
    this.newGameMessage = 'Start New Game',
    this.newGameSound,
    this.savedGameMessage = 'Play Saved Game',
    this.savedGameSound,
    this.creditsMessage = 'Show Credits',
    this.creditsSound,
    this.exitMessage = 'Exit',
    this.exitSound,
    this.onExitMessage = 'The game will now close.',
    this.onExitSound,
    this.soundOptionsMessage = 'Sound Options',
    this.soundOptionsSound,
    this.startGameCommandId,
  });

  /// Create an instance from a JSON object.
  factory MainMenuOptions.fromJson(final Map<String, dynamic> json) =>
      _$MainMenuOptionsFromJson(json);

  /// The title of the menu.
  String title;

  /// The music to play while the main menu is visible.
  Sound? music;

  /// How long to fade this menu.
  double? fadeTime;

  /// The message for the "Play New Game" option.
  String? newGameMessage;

  /// The sound for the "Play New Game" option.
  Sound? newGameSound;

  /// The message for the "Play Saved Game" option.
  String? savedGameMessage;

  /// The sound for the "Play Saved Game" option.
  Sound? savedGameSound;

  /// The message for the "Credits" option.
  String? creditsMessage;

  /// The sound for the "Credits" option.
  Sound? creditsSound;

  /// The sound for the "Sound Options" option.
  final String? soundOptionsMessage;

  /// The sound for the "Sound Options" option.
  Sound? soundOptionsSound;

  /// The message for the "Exit" option.
  String? exitMessage;

  /// The sound for the "Exit" option.
  Sound? exitSound;

  /// The message that will be shown as the game closes.
  String? onExitMessage;

  /// The sound that will be played as the game closes.
  Sound? onExitSound;

  /// The command to run to start a new game.
  String? startGameCommandId;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$MainMenuOptionsToJson(this);
}
