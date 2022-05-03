/// Provides the [LookAroundMenuItem] class.
import 'package:ziggurat/menus.dart';
import 'package:ziggurat/ziggurat.dart';

import '../../world_context.dart';
import '../json/sounds/audio_bus.dart';

/// A menu item to show an object.
class LookAroundMenuItem extends MenuItem {
  /// Create an instance.
  const LookAroundMenuItem({
    required this.worldContext,
    required final Message message,
    required final Widget widget,
    required this.sound,
    this.gain = 0.7,
    this.reverbId,
    this.x = 0.0,
    this.y = 0.0,
    this.z = 0.0,
  }) : super(
          message,
          widget,
        );

  /// The game to use.
  final WorldContext worldContext;

  /// The sound to play.
  final AssetReference sound;

  /// The gain to play [sound] at.
  final double gain;

  /// The reverb to use.
  final String? reverbId;

  /// The x coordinate.
  final double x;

  /// The y coordinate.
  final double y;

  /// THe z coordinate.
  final double z;

  /// Play a sound at the given coordinates.
  @override
  void onFocus(final Menu menu) {
    super.onFocus(menu);
    final audioBus = AudioBus(
      id: audioBusId,
      name: '${label.text}',
      gain: gain,
      panningType: PanningType.threeD,
      reverbId: reverbId,
      x: x,
      y: y,
      z: z,
    );
    worldContext.getAudioBus(audioBus).playSound(
          sound,
        );
  }

  /// Get an ID for an audio bus this instance can use.
  String get audioBusId => '$x.$y.$z:$reverbId';
}
