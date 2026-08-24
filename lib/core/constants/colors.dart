import 'package:flutter/material.dart';

/// Color palette for Irodoku - 9 distinct colors representing numbers 1-9
class IrodokuColors {
  static const List<Color> palette = [
    Color(0xFFFF0000), // Red
    Color(0xFFFFA500), // Orange
    Color(0xFFFFFF00), // Yellow
    Color(0xFF00AA00), // Green
    Color(0xFF00FFFF), // Cyan
    Color(0xFF0000FF), // Blue
    Color(0xFF8800FF), // Purple
    Color(0xFFFF00FF), // Magenta
    Color(0xFFFF69B4), // Pink
  ];

  /// Get color by number (1-9)
  static Color getColorByNumber(int number) {
    if (number < 1 || number > 9) {
      return Colors.grey[300]!;
    }
    return palette[number - 1];
  }

  /// Get color name by number
  static String getColorName(int number) {
    const names = ['Red', 'Orange', 'Yellow', 'Green', 'Cyan', 'Blue', 'Purple', 'Magenta', 'Pink'];
    if (number < 1 || number > 9) return 'Empty';
    return names[number - 1];
  }

  /// Background and utility colors
  static const Color background = Color(0xFF121212);
  static const Color surface = Color(0xFF1E1E1E);
  static const Color surfaceVariant = Color(0xFF2A2A2A);
  static const Color primary = Color(0xFF6200EE);
  static const Color onSurface = Color(0xFFFFFFFF);
}
