import 'cell_model.dart';

/// Represents the state of an Irodoku game
class GameModel {
  /// 9x9 grid of cells
  final List<List<Cell>> board;

  /// Game difficulty level
  final String difficulty;

  /// Game start time
  final DateTime startTime;

  /// Whether the game is completed
  bool isCompleted;

  /// Whether the game is paused
  bool isPaused;

  /// Number of mistakes made
  int mistakes;

  /// Maximum allowed mistakes
  final int maxMistakes;

  /// Move history for undo functionality
  final List<Move> history;

  /// Current move index in history
  int historyIndex;

  GameModel({
    required this.board,
    required this.difficulty,
    required this.startTime,
    this.isCompleted = false,
    this.isPaused = false,
    this.mistakes = 0,
    this.maxMistakes = 3,
    this.history = const [],
    this.historyIndex = -1,
  });

  /// Get elapsed time in seconds
  int get elapsedSeconds => DateTime.now().difference(startTime).inSeconds;

  /// Check if game is over (completed or max mistakes reached)
  bool get isGameOver => isCompleted || mistakes >= maxMistakes;

  /// Create a copy of this game
  GameModel copyWith({
    List<List<Cell>>? board,
    String? difficulty,
    DateTime? startTime,
    bool? isCompleted,
    bool? isPaused,
    int? mistakes,
    int? maxMistakes,
    List<Move>? history,
    int? historyIndex,
  }) {
    return GameModel(
      board: board ?? this.board,
      difficulty: difficulty ?? this.difficulty,
      startTime: startTime ?? this.startTime,
      isCompleted: isCompleted ?? this.isCompleted,
      isPaused: isPaused ?? this.isPaused,
      mistakes: mistakes ?? this.mistakes,
      maxMistakes: maxMistakes ?? this.maxMistakes,
      history: history ?? this.history,
      historyIndex: historyIndex ?? this.historyIndex,
    );
  }
}

/// Represents a single move in game history
class Move {
  final int row;
  final int col;
  final int previousValue;
  final int newValue;
  final DateTime timestamp;

  Move({
    required this.row,
    required this.col,
    required this.previousValue,
    required this.newValue,
    required this.timestamp,
  });
}
