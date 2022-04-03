/// Provides the [Statistics] class.
import 'package:json_annotation/json_annotation.dart';

import '../../../worldsmith.dart';

part 'statistics.g.dart';

/// The type for a statistics map.
typedef StatsMap = Map<String, int>;

/// The stats for an object.
@JsonSerializable()
class Statistics {
  /// Create an instance.
  const Statistics({
    required this.defaultStats,
    required this.currentStats,
  });

  /// Create an instance from a JSON object.
  factory Statistics.fromJson(final Map<String, dynamic> json) =>
      _$StatisticsFromJson(json);

  /// The default stats for this object.
  final StatsMap defaultStats;

  /// The current statistics for this object.
  final StatsMap currentStats;

  /// Get the value of a [stat].
  int getStat(final WorldStat stat) =>
      currentStats[stat.id] ?? defaultStats[stat.id] ?? stat.defaultValue;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$StatisticsToJson(this);
}
