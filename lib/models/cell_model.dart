/// Represents a single cell in the Irodoku board
class Cell {
  /// The row index (0-8)
  final int row;

  /// The column index (0-8)
  final int col;

  /// The value (1-9) or 0 if empty
  int value;

  /// The initial/fixed value (cannot be changed by player)
  final int initialValue;

  /// User's guess or note (can be edited)
  int userValue;

  /// List of pencil marks/candidates (1-9)
  Set<int> candidates;

  /// Whether this cell is selected
  bool isSelected;

  /// Whether this cell is highlighted due to row/col/box selection
  bool isHighlighted;

  /// Whether the current value is correct
  bool isCorrect;

  Cell({
    required this.row,
    required this.col,
    this.value = 0,
    this.initialValue = 0,
    this.userValue = 0,
    this.candidates = const {},
    this.isSelected = false,
    this.isHighlighted = false,
    this.isCorrect = true,
  });

  /// Whether this cell is given/fixed
  bool get isGiven => initialValue != 0;

  /// Whether this cell is empty
  bool get isEmpty => value == 0 && initialValue == 0;

  /// Create a copy of this cell
  Cell copyWith({
    int? row,
    int? col,
    int? value,
    int? initialValue,
    int? userValue,
    Set<int>? candidates,
    bool? isSelected,
    bool? isHighlighted,
    bool? isCorrect,
  }) {
    return Cell(
      row: row ?? this.row,
      col: col ?? this.col,
      value: value ?? this.value,
      initialValue: initialValue ?? this.initialValue,
      userValue: userValue ?? this.userValue,
      candidates: candidates ?? this.candidates,
      isSelected: isSelected ?? this.isSelected,
      isHighlighted: isHighlighted ?? this.isHighlighted,
      isCorrect: isCorrect ?? this.isCorrect,
    );
  }

  @override
  String toString() => 'Cell($row, $col): value=$value, initial=$initialValue';
}
