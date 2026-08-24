/// Application-wide constants
class AppConstants {
  // Game board dimensions
  static const int boardSize = 9;
  static const int boxSize = 3;
  static const int totalCells = boardSize * boardSize;

  // Game difficulty levels
  static const Map<String, int> difficultyClues = {
    'Easy': 40,
    'Medium': 32,
    'Hard': 24,
    'Expert': 17,
  };

  // Animation durations
  static const Duration cellAnimationDuration = Duration(milliseconds: 300);
  static const Duration boardGenerationDuration = Duration(seconds: 2);

  // Storage keys
  static const String lastGameKey = 'last_game';
  static const String statsKey = 'game_stats';
  static const String settingsKey = 'app_settings';
}
