/// Provides the [MainMenuOptions] class.
import 'package:json_annotation/json_annotation.dart';

import '../../../worldsmith.dart';

part 'main_menu_options.g.dart';

/// The options for the main menu.
@JsonSerializable()
class MainMenuOptions {
  /// Create an instance.
  const MainMenuOptions({
    this.options = const MenuOptions(title: 'Main Menu'),
    this.newGameTitle = 'Start New Game',
    this.savedGameTitle = 'Play Saved Game',
    this.creditsTitle = 'Show Credits',
    this.exitTitle = 'Exit',
  });

  /// Create an instance from a JSON object.
  factory MainMenuOptions.fromJson(Map<String, dynamic> json) =>
      _$MainMenuOptionsFromJson(json);

  /// THe title and music.
  final MenuOptions options;

  /// The title of the "Play New Game" option.
  final String newGameTitle;

  /// The title of the "Play Saved Game" option.
  final String savedGameTitle;

  /// The title of the "Credits" option.
  final String creditsTitle;

  /// The title of the "Exit" option.
  final String exitTitle;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$MainMenuOptionsToJson(this);
}
