/// Provides the [WalkingOptions] class.
import 'package:json_annotation/json_annotation.dart';

import '../sounds/sound.dart';

part 'walking_options.g.dart';

/// A class for configuring footsteps.
@JsonSerializable()
class WalkingOptions {
  /// Create an instance.
  WalkingOptions({
    required this.interval,
    this.distance = 0.5,
    this.sound,
    this.joystickValue = 0.2,
  });

  /// Create an instance from a JSON object.
  factory WalkingOptions.fromJson(final Map<String, dynamic> json) =>
      _$WalkingOptionsFromJson(json);

  /// How many milliseconds must elapse between taking a footstep.
  int interval;

  /// How far this footstep will take whatever is taking it.
  double distance;

  /// The sound that will play when taking a footstep.
  Sound? sound;

  /// The minimum value of a joystick for this walking mode to be used.
  double joystickValue;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$WalkingOptionsToJson(this);
}
