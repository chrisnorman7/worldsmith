import 'package:dart_sdl/dart_sdl.dart';
import 'package:test/test.dart';
import 'package:worldsmith/world_context.dart';
import 'package:worldsmith/worldsmith.dart';
import 'package:ziggurat/sound.dart';
import 'package:ziggurat/ziggurat.dart';

void main() {
  group(
    'AudioBus tests',
    () {
      test(
        'Initialisation',
        () {
          final bus = AudioBus(id: 'bus1', name: 'Bus 1');
          expect(bus.gain, isNull);
          expect(bus.panningType, PanningType.direct);
          expect(bus.reverbId, isNull);
          expect(bus.x, isZero);
          expect(bus.y, isZero);
          expect(bus.z, isZero);
        },
      );
      test(
        '.position',
        () {
          final bus = AudioBus(
            id: 'bus',
            name: 'Audio Bus',
            x: 1.0,
            y: 2.0,
            z: 3.0,
          );
          expect(bus.position, unpanned);
          bus.panningType = PanningType.angular;
          expect(
            bus.position,
            predicate(
              (final value) =>
                  value is SoundPositionAngular &&
                  value.azimuth == 1.0 &&
                  value.elevation == 2.0,
            ),
          );
          bus.panningType = PanningType.scalar;
          expect(
            bus.position,
            predicate(
              (final value) =>
                  value is SoundPositionScalar && value.scalar == 1.0,
            ),
          );
          bus.panningType = PanningType.threeD;
          expect(
            bus.position,
            predicate(
              (final value) =>
                  value is SoundPosition3d &&
                  value.x == 1.0 &&
                  value.y == 2.0 &&
                  value.z == 3.0,
            ),
          );
        },
      );
    },
  );
  group(
    'World',
    () {
      test(
        '.getAudioBus',
        () {
          final bus1 = AudioBus(id: 'bus1', name: 'Bus 1');
          final bus2 = AudioBus(id: 'bus2', name: 'Bus 2');
          final world = World(audioBusses: [bus1, bus2]);
          expect(world.getAudioBus(bus1.id), bus1);
          expect(world.getAudioBus(bus2.id), bus2);
        },
      );
    },
  );
  group(
    'WorldContext',
    () {
      test(
        '.getAudioBus',
        () {
          final reverbPresetReference = ReverbPresetReference(
            id: 'reverb',
            reverbPreset: const ReverbPreset(name: 'Reverb 1'),
          );
          final bus = AudioBus(
            id: 'bus1',
            name: 'Audio Bus 1',
            gain: 0.5,
            panningType: PanningType.threeD,
            reverbId: reverbPresetReference.id,
            x: 1.0,
            y: 2.0,
            z: 3.0,
          );
          final world = World(
            audioBusses: [bus],
            reverbs: [reverbPresetReference],
          );
          final game = Game('Audio Bus Tests');
          final sdl = Sdl();
          final worldContext = WorldContext(sdl: sdl, game: game, world: world);
          final reverb = worldContext.getReverb(reverbPresetReference);
          final channel = worldContext.getAudioBus(bus);
          expect(channel.gain, bus.gain);
          expect(
            channel.position,
            predicate(
              (final value) =>
                  value is SoundPosition3d &&
                  value.x == bus.x &&
                  value.y == bus.y &&
                  value.z == bus.z,
            ),
          );
          expect(channel.reverb, reverb.id);
        },
      );
    },
  );
}
