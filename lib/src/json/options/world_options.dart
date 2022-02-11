/// Provides the [WorldOptions] class.
import 'package:json_annotation/json_annotation.dart';

import '../world.dart';

part 'world_options.g.dart';

/// The options for a [World] instance.
@JsonSerializable()
class WorldOptions {
  /// Create an instance.
  WorldOptions({
    this.framesPerSecond = 60,
  });

  /// Create an instance from a JSON object.
  factory WorldOptions.fromJson(Map<String, dynamic> json) =>
      _$WorldOptionsFromJson(json);

  /// The frames per second for this game.
  ///
  /// The lower you set this, the slower your game will run, but the less
  /// resources it will use.
  int framesPerSecond;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$WorldOptionsToJson(this);
}
