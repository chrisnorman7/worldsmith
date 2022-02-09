/// Provides the [Sound] class.
import 'package:json_annotation/json_annotation.dart';

part 'sound.g.dart';

/// The sound class.
///
/// Instances of this class represent sounds that should be played by the
/// engine.
@JsonSerializable()
class Sound {
  /// Create an instance.
  const Sound({required this.id, this.gain = 0.7});

  /// Create an instance from a JSON object.
  factory Sound.fromJson(Map<String, dynamic> json) => _$SoundFromJson(json);

  /// The ID of the sound to play.
  ///
  /// Which asset store this sound belongs to will depend on what this sound is
  /// used for.
  final String id;

  /// The gain of this sound.
  final double gain;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$SoundToJson(this);
}
