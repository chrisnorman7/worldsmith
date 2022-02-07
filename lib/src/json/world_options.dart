/// Provides the [WorldOptions] class.
import 'package:json_annotation/json_annotation.dart';

import 'world.dart';

part 'world_options.g.dart';

/// The options for a [World] instance.
@JsonSerializable()
class WorldOptions {
  /// Create an instance.
  const WorldOptions({
    this.mainMenuTitle = 'Main Menu',
    this.mainMenuMusicId,
    this.framesPerSecond = 60,
    this.creditsMenuItemTitle = 'Credits',
    this.playNewGameMenuItemTitle = 'Start New Game',
    this.playSavedGameMenuItemTitle = 'Play Saved Game',
    this.exitMenuItemTitle = 'Exit',
    this.menuMoveSoundId,
    this.menuActivateSoundId,
    this.creditsMenuTitle = 'Acknowledgements',
    this.creditMusicId,
  });

  /// Create an instance from a JSON object.
  factory WorldOptions.fromJson(Map<String, dynamic> json) =>
      _$WorldOptionsFromJson(json);

  /// The title of the main menu.
  final String mainMenuTitle;

  /// The ID of an asset from the music asset store for main menu music.
  final String? mainMenuMusicId;

  /// The frames per second for this game.
  ///
  /// The lower you set this, the slower your game will run, but the less
  /// resources it will use.
  final int framesPerSecond;

  /// The title of the "play new game" option.
  final String playNewGameMenuItemTitle;

  /// The title of the "Play Saved Game" menu item.
  final String playSavedGameMenuItemTitle;

  /// The title of the menu item that shows the credits menu.
  final String creditsMenuItemTitle;

  /// The title of the "exit" option.
  final String exitMenuItemTitle;

  /// The ID of the menu move sound from the interface sounds asset store.
  final String? menuMoveSoundId;

  /// The ID of the menu activate sound from the interface sounds asset store.
  final String? menuActivateSoundId;

  /// The title of the "Credits" menu.
  final String creditsMenuTitle;

  /// The ID of an asset from the music assets store for credits music.
  final String? creditMusicId;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$WorldOptionsToJson(this);
}
