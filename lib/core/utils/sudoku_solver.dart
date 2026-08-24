/// Sudoku puzzle generator and solver
class SudokuSolver {
  late List<List<int>> solution;
  late List<List<int>> puzzle;

  /// Generate a complete valid sudoku solution
  List<List<int>> generateSolution() {
    solution = List.generate(9, (_) => List.filled(9, 0));
    _fillDiagonal();
    _solveSudoku(solution);
    return solution;
  }

  /// Create a puzzle by removing numbers from a complete solution
  List<List<int>> createPuzzle(int clues) {
    generateSolution();
    puzzle = [for (var row in solution) [...row]];
    
    int cellsToRemove = 81 - clues;
    int removed = 0;
    
    while (removed < cellsToRemove) {
      int row = DateTime.now().millisecond % 9;
      int col = (DateTime.now().millisecond ~/ 9) % 9;
      
      if (puzzle[row][col] != 0) {
        puzzle[row][col] = 0;
        removed++;
      }
    }
    
    return puzzle;
  }

  /// Solve a sudoku puzzle
  bool _solveSudoku(List<List<int>> board) {
    for (int row = 0; row < 9; row++) {
      for (int col = 0; col < 9; col++) {
        if (board[row][col] == 0) {
          for (int num = 1; num <= 9; num++) {
            if (_isValid(board, row, col, num)) {
              board[row][col] = num;
              if (_solveSudoku(board)) {
                return true;
              }
              board[row][col] = 0;
            }
          }
          return false;
        }
      }
    }
    return true;
  }

  /// Check if a number is valid at a position
  bool _isValid(List<List<int>> board, int row, int col, int num) {
    // Check row
    for (int x = 0; x < 9; x++) {
      if (board[row][x] == num) return false;
    }

    // Check column
    for (int x = 0; x < 9; x++) {
      if (board[x][col] == num) return false;
    }

    // Check 3x3 box
    int boxRow = row - row % 3;
    int boxCol = col - col % 3;
    for (int i = boxRow; i < boxRow + 3; i++) {
      for (int j = boxCol; j < boxCol + 3; j++) {
        if (board[i][j] == num) return false;
      }
    }

    return true;
  }

  /// Fill the diagonal 3x3 boxes (optimization for generation)
  void _fillDiagonal() {
    for (int box = 0; box < 3; box++) {
      List<int> nums = List.generate(9, (i) => i + 1)..shuffle();
      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          solution[box * 3 + i][box * 3 + j] = nums[i * 3 + j];
        }
      }
    }
  }
}
