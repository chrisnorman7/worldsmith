import 'package:test/test.dart';
import 'package:worldsmith/worldsmith.dart';

void main() {
  group(
    'Statistics',
    () {
      final str = WorldStat(
        id: 'str',
        name: 'Strength',
        description: 'How hard you can hit',
        defaultValue: 30,
      );
      final dex = WorldStat(
        id: 'dex',
        name: 'Dexterity',
        description: 'How fast you can dodge',
        defaultValue: 40,
      );
      test(
        'Initialise',
        () {
          const stats = Statistics(defaultStats: {}, currentStats: {});
          expect(stats.currentStats, isEmpty);
          expect(stats.defaultStats, isEmpty);
        },
      );
      test(
        'getStat',
        () {
          // ignore: prefer_const_constructors
          final stats = Statistics(defaultStats: {}, currentStats: {});
          expect(stats.getStat(str), str.defaultValue);
          expect(stats.getStat(dex), dex.defaultValue);
          stats.defaultStats[str.id] = 20;
          expect(stats.getStat(str), stats.defaultStats[str.id]);
          expect(stats.getStat(dex), dex.defaultValue);
          stats.currentStats[dex.id] = 10;
          expect(stats.getStat(str), stats.defaultStats[str.id]);
          expect(stats.getStat(dex), stats.currentStats[dex.id]);
          stats.currentStats[dex.id] = 12345;
          expect(stats.getStat(str), stats.defaultStats[str.id]);
          expect(stats.getStat(dex), stats.currentStats[dex.id]);
        },
      );
    },
  );
}
