/// Provides the [WalkingOptions] class.
import 'package:json_annotation/json_annotation.dart';

import '../sound.dart';

part 'walking_options.g.dart';

/// A class for configuring footsteps.
@JsonSerializable()
class WalkingOptions {
  /// Create an instance.
  const WalkingOptions({
    required this.interval,
    required this.distance,
    required this.sound,
  });

  /// Create an instance from a JSON object.
  factory WalkingOptions.fromJson(Map<String, dynamic> json) =>
      _$WalkingOptionsFromJson(json);

  /// How many milliseconds must elapse between taking a footstep.
  final int interval;

  /// How far this footstep will take whatever is taking it.
  final double distance;

  /// The sound that will play when taking a footstep.
  final Sound sound;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$WalkingOptionsToJson(this);
}
