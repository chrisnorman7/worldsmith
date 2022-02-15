/// Provides the [MainMenuOptions] class.
import 'package:json_annotation/json_annotation.dart';

import '../sound.dart';

part 'main_menu_options.g.dart';

/// The options for the main menu.
@JsonSerializable()
class MainMenuOptions {
  /// Create an instance.
  MainMenuOptions({
    this.title = 'Main Menu',
    this.music,
    this.fadeTime = 4.0,
    this.newGameTitle = 'Start New Game',
    this.savedGameTitle = 'Play Saved Game',
    this.creditsTitle = 'Show Credits',
    this.exitTitle = 'Exit',
    this.exitMessage = 'The game will now close.',
  });

  /// Create an instance from a JSON object.
  factory MainMenuOptions.fromJson(Map<String, dynamic> json) =>
      _$MainMenuOptionsFromJson(json);

  /// The title of the menu.
  String title;

  /// The music to play while the main menu is visible.
  Sound? music;

  /// How long to fade this menu.
  double? fadeTime;

  /// The title of the "Play New Game" option.
  String newGameTitle;

  /// The title of the "Play Saved Game" option.
  String savedGameTitle;

  /// The title of the "Credits" option.
  String creditsTitle;

  /// The title of the "Exit" option.
  String exitTitle;

  /// The title that will be shown as the game closes.
  String exitMessage;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$MainMenuOptionsToJson(this);
}
