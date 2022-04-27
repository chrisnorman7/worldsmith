/// Provides the [AudioBus] class.
import 'package:json_annotation/json_annotation.dart';
import 'package:ziggurat/sound.dart';

part 'audio_bus.g.dart';

/// The type of output to use.
enum PanningType {
  /// Direct source, no panning.
  direct,

  /// Stereo panning, using an angle and an elevation.
  angular,

  /// Stereo panning, using a scalar.
  scalar,

  /// Full 3d, x y and z.
  threeD,
}

/// A bus to send audio through.
///
/// The term `SoundChannel` has not been used, because of the conflict with the
/// [SoundChannel] class.
@JsonSerializable()
class AudioBus {
  /// Create an instance.
  AudioBus({
    required this.id,
    required this.name,
    this.reverbId,
    this.gain,
    this.panningType = PanningType.direct,
    this.x = 0.0,
    this.y = 0.0,
    this.z = 0.0,
  });

  /// Create an instance from a JSON object.
  factory AudioBus.fromJson(final Map<String, dynamic> json) =>
      _$AudioBusFromJson(json);

  /// The ID of this bus.
  final String id;

  /// The name of this bus.
  String name;

  /// The ID of the reverb preset that should be applied to this channel.
  String? reverbId;

  /// The gain for this channel.
  ///
  /// If this value is `null`, then the default gain for the world will be used.
  double? gain;

  /// The type of panning to use.
  ///
  /// If [panningType] is [PanningType.direct], the values of [x], [y], and [z]
  /// are ignored.
  ///
  /// If [panningType] is [PanningType.scalar], then [x] will be used as the left / right balance.
  ///
  /// If [panningType] is [PanningType.angular], then [x] will be used as the
  /// azimuth, and [y] will be used as the elevation.
  ///
  /// If [panningType] is [PanningType.threeD], then [x], [y], and [z] will be
  /// used as expected.
  PanningType panningType;

  /// The x coordinate.
  ///
  /// If [panningType] is [PanningType.scalar], this value represents the left / right balance.
  ///
  /// If [panningType] is [PanningType.angular], this value will represent the
  /// azimuth.
  double x;

  /// The y coordinate.
  ///
  /// If [panningType] is [PanningType.angular], this value will be the
  /// elevation.
  ///
  /// If [panningType] is [PanningType.threeD], this value will be the y
  /// coordinate.
  double y;

  /// The z coordinate.
  ///
  /// If [panningType] is anything except [PanningType.threeD], this value is
  /// ignored.
  double z;

  /// Get an appropriate sound position.
  SoundPosition get position {
    switch (panningType) {
      case PanningType.direct:
        return unpanned;
      case PanningType.angular:
        return SoundPositionAngular(
          azimuth: x,
          elevation: y,
        );
      case PanningType.scalar:
        return SoundPositionScalar(scalar: x);
      case PanningType.threeD:
        return SoundPosition3d(
          x: x,
          y: y,
          z: z,
        );
    }
  }

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$AudioBusToJson(this);
}
