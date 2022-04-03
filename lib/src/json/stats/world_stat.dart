/// Provides the [WorldStat] class.
import 'package:json_annotation/json_annotation.dart';

part 'world_stat.g.dart';

/// A stat in the world.
@JsonSerializable()
class WorldStat {
  /// Create an instance.
  WorldStat({
    required this.id,
    this.name = 'Untitled Stat',
    this.description = 'A nondescript statistic',
    this.defaultValue = 20,
  });

  /// Create an instance from a JSON object.
  factory WorldStat.fromJson(final Map<String, dynamic> json) =>
      _$WorldStatFromJson(json);

  /// The ID of this stat.
  final String id;

  /// The name of this stat.
  String name;

  /// The description of this stat.
  String description;

  /// The default value for this stat.
  int defaultValue;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$WorldStatToJson(this);
}
