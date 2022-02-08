/// Provides the [WorldOptions] class.
import 'package:json_annotation/json_annotation.dart';

import '../world.dart';

part 'world_options.g.dart';

/// The options for a [World] instance.
@JsonSerializable()
class WorldOptions {
  /// Create an instance.
  const WorldOptions({
    this.framesPerSecond = 60,
    this.creditsMenuTitle = 'Acknowledgements',
    this.creditMusicId,
  });

  /// Create an instance from a JSON object.
  factory WorldOptions.fromJson(Map<String, dynamic> json) =>
      _$WorldOptionsFromJson(json);

  /// The frames per second for this game.
  ///
  /// The lower you set this, the slower your game will run, but the less
  /// resources it will use.
  final int framesPerSecond;

  /// The title of the "Credits" menu.
  final String creditsMenuTitle;

  /// The ID of an asset from the music assets store for credits music.
  final String? creditMusicId;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$WorldOptionsToJson(this);
}
