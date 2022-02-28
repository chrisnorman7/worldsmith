/// Provides the [WorldOptions] class.
import 'package:dart_sdl/dart_sdl.dart';
import 'package:json_annotation/json_annotation.dart';

import '../world.dart';

part 'world_options.g.dart';

/// The options for a [World] instance.
@JsonSerializable()
class WorldOptions {
  /// Create an instance.
  WorldOptions({
    this.version = '0.0.0',
    this.framesPerSecond = 60,
    this.orgName = 'com.example',
    this.appName = 'untitled_game',
  });

  /// Create an instance from a JSON object.
  factory WorldOptions.fromJson(Map<String, dynamic> json) =>
      _$WorldOptionsFromJson(json);

  /// The version of the game.
  String version;

  /// The frames per second for this game.
  ///
  /// The lower you set this, the slower your game will run, but the less
  /// resources it will use.
  int framesPerSecond;

  /// The name of the organisation who is making this game.
  ///
  /// This value should probably be in reverse domain name notation, such as
  /// "com.apple.developer", although this is not enforced.
  ///
  /// This value will be used along with [appName] to get the full directory
  /// name where game data will be stored, using [Sdl.getPrefPath].
  String orgName;

  /// The computer-friendly name of this game.
  ///
  /// This data includes the player's preferences, and their trigger map.
  ///
  /// This value will be used along with [orgName] with [Sdl.getPrefPath] to get
  /// the full directory.
  String appName;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$WorldOptionsToJson(this);
}
