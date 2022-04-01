import 'package:ziggurat/ziggurat.dart';

/// A game that stores text.
class CustomGame extends Game {
  /// Create an instance.
  CustomGame(final String title)
      : strings = [],
        super(title);

  /// The stored messages.
  final List<String> strings;

  @override
  void outputText(final String text) => strings.add(text);
}
