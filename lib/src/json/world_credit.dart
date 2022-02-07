/// Provides the [WorldCredit] class.
import 'package:json_annotation/json_annotation.dart';

part 'world_credit.g.dart';

/// A credit for the game.
///
/// Instances of this class will be used to generate a credits menu.
@JsonSerializable()
class WorldCredit {
  /// Create an instance.
  const WorldCredit({
    required this.title,
    this.url,
    this.assetId,
  });

  /// Create an instance from a JSON object.
  factory WorldCredit.fromJson(Map<String, dynamic> json) =>
      _$WorldCreditFromJson(json);

  /// The title of this credit.
  final String title;

  /// The URL to open when this credit is clicked.
  final String? url;

  /// The ID of an asset from the credits asset store to play when this credit
  /// is selected.
  final String? assetId;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$WorldCreditToJson(this);
}
