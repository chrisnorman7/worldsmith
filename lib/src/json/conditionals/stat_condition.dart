/// Provides the [StatCondition] class.
import 'package:json_annotation/json_annotation.dart';

import '../commands/world_command.dart';
import '../stats/world_stat.dart';
import '_conditionals.dart';

part 'stat_condition.g.dart';

/// A condition based on a [WorldStat] instance.
///
/// The stats which are checked will depend on the target of the [WorldCommand]
/// instance.
@JsonSerializable()
class StatCondition {
  /// Create an instance.
  StatCondition({
    required this.statId,
    required this.value,
    this.operator = ConditionalOperator.equal,
  });

  /// Create an instance from a JSON object.
  factory StatCondition.fromJson(final Map<String, dynamic> json) =>
      _$StatConditionFromJson(json);

  /// The ID of the [WorldStat] instance.
  String statId;

  /// The operator to use.
  ConditionalOperator operator;

  /// The value of the stat.
  int value;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$StatConditionToJson(this);
}
