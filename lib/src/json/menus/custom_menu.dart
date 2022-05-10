/// Provides the [CustomMenu] class.
import 'package:json_annotation/json_annotation.dart';

import '../commands/call_command.dart';
import '../sounds/sound.dart';
import 'custom_menu_item.dart';

part 'custom_menu.g.dart';

/// A custom menu.
@JsonSerializable()
class CustomMenu {
  /// Create an instance.
  CustomMenu({
    required this.id,
    required this.title,
    this.music,
    final List<CustomMenuItem>? items,
    this.cancellable = true,
    this.fadeTime,
    this.cancelCommand,
  }) : items = items ?? [];

  /// Create an instance from a JSON object.
  factory CustomMenu.fromJson(final Map<String, dynamic> json) =>
      _$CustomMenuFromJson(json);

  /// The ID of this menu.
  final String id;

  /// The title of this menu.
  String title;

  /// The music to play when this menu is shown.
  Sound? music;

  /// The items in this menu.
  final List<CustomMenuItem> items;

  /// Whether or not this menu can be cancelled.
  ///
  /// If this value is `true`, then the menu will simply be popped. To change
  /// this behaviour, set the [cancelCommand] property.
  bool cancellable;

  /// The fade time for this menu.
  double? fadeTime;

  /// The command to call when this menu is cancelled.
  CallCommand? cancelCommand;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$CustomMenuToJson(this);
}
