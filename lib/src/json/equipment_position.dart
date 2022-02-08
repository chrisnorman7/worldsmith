/// Provides the [EquipmentPosition] class.
import 'package:json_annotation/json_annotation.dart';

part 'equipment_position.g.dart';

/// A position where equipment can be worn.
@JsonSerializable()
class EquipmentPosition {
  /// Create an instance.
  const EquipmentPosition({
    required this.id,
    required this.name,
  });

  /// Create an instance from a JSON object.
  factory EquipmentPosition.fromJson(Map<String, dynamic> json) =>
      _$EquipmentPositionFromJson(json);

  /// The ID of this position.
  final String id;

  /// The name of this position.
  final String name;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$EquipmentPositionToJson(this);
}
