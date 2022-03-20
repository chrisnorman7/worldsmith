/// Provides the [PlayRumble] class.
import 'package:json_annotation/json_annotation.dart';

part 'play_rumble.g.dart';

/// Play a simple rumble effect.
@JsonSerializable()
class PlayRumble {
  /// Create an instance.
  PlayRumble({
    this.leftFrequency = 65535,
    this.rightFrequency = 65535,
    this.duration = 500,
  });

  /// Create an instance from a JSON object.
  factory PlayRumble.fromJson(Map<String, dynamic> json) =>
      _$PlayRumbleFromJson(json);

  /// The strength of the left motor.
  ///
  /// This value should be between `0` and `65535`.
  int leftFrequency;

  /// The strength of the right motor.
  ///
  /// This value should be between `0` and `65535`.
  int rightFrequency;

  /// The number of milliseconds the rumble should go on for.
  int duration;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$PlayRumbleToJson(this);
}
