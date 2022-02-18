/// Provides the [MainMenuOptions] class.
import 'package:json_annotation/json_annotation.dart';

import '../messages/custom_message.dart';
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
    CustomMessage? newGameMessage,
    CustomMessage? savedGameMessage,
    CustomMessage? creditsMessage,
    CustomMessage? exitMessage,
    CustomMessage? onExitMessage,
  })  : newGameMessage =
            newGameMessage ?? CustomMessage(text: 'Start New Game'),
        savedGameMessage =
            savedGameMessage ?? CustomMessage(text: 'Play Saved Game'),
        creditsMessage = creditsMessage ?? CustomMessage(text: 'Show Credits'),
        exitMessage = exitMessage ?? CustomMessage(text: 'Exit'),
        onExitMessage =
            onExitMessage ?? CustomMessage(text: 'The game will now close.');

  /// Create an instance from a JSON object.
  factory MainMenuOptions.fromJson(Map<String, dynamic> json) =>
      _$MainMenuOptionsFromJson(json);

  /// The title of the menu.
  String title;

  /// The music to play while the main menu is visible.
  Sound? music;

  /// How long to fade this menu.
  double? fadeTime;

  /// The message for the "Play New Game" option.
  final CustomMessage newGameMessage;

  /// The message for the "Play Saved Game" option.
  final CustomMessage savedGameMessage;

  /// The message for the "Credits" option.
  final CustomMessage creditsMessage;

  /// The message for the "Exit" option.
  final CustomMessage exitMessage;

  /// The message that will be used as the game closes.
  final CustomMessage onExitMessage;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$MainMenuOptionsToJson(this);
}
