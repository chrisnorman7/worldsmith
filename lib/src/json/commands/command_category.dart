import 'package:json_annotation/json_annotation.dart';

import 'world_command.dart';

part 'command_category.g.dart';

/// A list of commands.
typedef CommandList = List<WorldCommand>;

/// A category, which holds a list of [commands].
@JsonSerializable()
class CommandCategory {
  /// Create an instance.
  CommandCategory({
    required this.id,
    required this.name,
    required this.commands,
  });

  /// Create an instance from a JSON object.
  factory CommandCategory.fromJson(Map<String, dynamic> json) =>
      _$CommandCategoryFromJson(json);

  /// The ID for this category.
  final String id;

  /// The name of this category.
  String name;

  /// THe commands that belong to this category.
  final CommandList commands;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$CommandCategoryToJson(this);
}
