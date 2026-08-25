import 'package:irodoku/core/constants/app_constants.dart';
import 'package:irodoku/core/utils/sudoku_solver.dart';
import 'package:irodoku/models/cell_model.dart';
import 'package:irodoku/models/game_model.dart';

/// Service to handle game logic and operations
class GameService {
  final SudokuSolver _solver = SudokuSolver();

  /// Initialize a new game with given difficulty
  GameModel initializeGame(String difficulty) {
    final clues = AppConstants.difficultyClues[difficulty] ?? 32;
    final puzzle = _solver.createPuzzle(clues);
    final solution = _solver.solution;

    // Create board from puzzle
    List<List<Cell>> board = [];
    for (int row = 0; row < 9; row++) {
      List<Cell> rowCells = [];
      for (int col = 0; col < 9; col++) {
        final value = puzzle[row][col];
        rowCells.add(
          Cell(
            row: row,
            col: col,
            value: value,
            initialValue: value,
            userValue: value,
            isCorrect: value == solution[row][col],
          ),
        );
      }
      board.add(rowCells);
    }

    return GameModel(
      board: board,
      difficulty: difficulty,
      startTime: DateTime.now(),
      isCompleted: false,
      isPaused: false,
      mistakes: 0,
      maxMistakes: 3,
    );
  }

  /// Place a value in a cell
  GameModel placeValue(GameModel game, int row, int col, int value) {
    final newBoard = _deepCopyBoard(game.board);
    final cell = newBoard[row][col];

    if (cell.isGiven) return game; // Can't modify given cells

    cell.value = value;
    cell.userValue = value;

    return game.copyWith(board: newBoard);
  }

  /// Clear a cell
  GameModel clearCell(GameModel game, int row, int col) {
    final newBoard = _deepCopyBoard(game.board);
    final cell = newBoard[row][col];

    if (cell.isGiven) return game;

    cell.value = 0;
    cell.userValue = 0;
    cell.candidates.clear();

    return game.copyWith(board: newBoard);
  }

  /// Check if the current board state is valid
  bool isBoardValid(List<List<Cell>> board) {
    for (int row = 0; row < 9; row++) {
      for (int col = 0; col < 9; col++) {
        final cell = board[row][col];
        if (cell.value == 0) continue;

        // Check row
        for (int x = 0; x < 9; x++) {
          if (x != col && board[row][x].value == cell.value) {
            return false;
          }
        }

        // Check column
        for (int x = 0; x < 9; x++) {
          if (x != row && board[x][col].value == cell.value) {
            return false;
          }
        }

        // Check 3x3 box
        int boxRow = row - row % 3;
        int boxCol = col - col % 3;
        for (int i = boxRow; i < boxRow + 3; i++) {
          for (int j = boxCol; j < boxCol + 3; j++) {
            if ((i != row || j != col) && board[i][j].value == cell.value) {
              return false;
            }
          }
        }
      }
    }
    return true;
  }

  /// Check if the board is completely solved
  bool isBoardComplete(List<List<Cell>> board) {
    for (int row = 0; row < 9; row++) {
      for (int col = 0; col < 9; col++) {
        if (board[row][col].value == 0) return false;
      }
    }
    return isBoardValid(board);
  }

  /// Get all cells in the same row
  List<Cell> getCellsInRow(List<List<Cell>> board, int row) {
    return board[row];
  }

  /// Get all cells in the same column
  List<Cell> getCellsInColumn(List<List<Cell>> board, int col) {
    return [for (int row = 0; row < 9; row++) board[row][col]];
  }

  /// Get all cells in the same 3x3 box
  List<Cell> getCellsInBox(List<List<Cell>> board, int row, int col) {
    int boxRow = row - row % 3;
    int boxCol = col - col % 3;
    List<Cell> cells = [];
    for (int i = boxRow; i < boxRow + 3; i++) {
      for (int j = boxCol; j < boxCol + 3; j++) {
        cells.add(board[i][j]);
      }
    }
    return cells;
  }

  /// Get candidate values for a cell
  Set<int> getCandidates(List<List<Cell>> board, int row, int col) {
    final cell = board[row][col];
    if (cell.value != 0) return {};

    Set<int> candidates = {1, 2, 3, 4, 5, 6, 7, 8, 9};

    // Remove values in same row
    for (var c in getCellsInRow(board, row)) {
      candidates.remove(c.value);
    }

    // Remove values in same column
    for (var c in getCellsInColumn(board, col)) {
      candidates.remove(c.value);
    }

    // Remove values in same box
    for (var c in getCellsInBox(board, row, col)) {
      candidates.remove(c.value);
    }

    return candidates;
  }

  /// Deep copy the board
  List<List<Cell>> _deepCopyBoard(List<List<Cell>> board) {
    return [
      for (var row in board)
        [for (var cell in row) cell.copyWith()]
    ];
  }
}
