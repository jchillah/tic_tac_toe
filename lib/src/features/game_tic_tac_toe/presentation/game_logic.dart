import 'dart:math';

class GameLogic {
  late List<List<String>> _board;
  late String _currentPlayer;
  String? _winner;

  GameLogic() {
    _resetBoard();
  }

  void _resetBoard() {
    _board = List.generate(3, (_) => List.filled(3, ''));
    _currentPlayer = 'X';
    _winner = null;
  }

  String get currentPlayer => _currentPlayer;
  String? get winner => _winner;
  List<List<String>> get board => _board;

  bool _checkWinner(int row, int col) {
    // Check row
    if (_board[row].every((cell) => cell == _currentPlayer)) {
      return true;
    }
    // Check column
    if (_board.every((r) => r[col] == _currentPlayer)) {
      return true;
    }
    // Check diagonals
    if (row == col &&
        _board.every((r) => r[_board.indexOf(r)] == _currentPlayer)) {
      return true;
    }
    if (row + col == 2 &&
        _board.every((r) => r[2 - _board.indexOf(r)] == _currentPlayer)) {
      return true;
    }
    return false;
  }

  void makeMove(int row, int col) {
    if (_board[row][col] != '' || _winner != null) {
      return;
    }
    _board[row][col] = _currentPlayer;
    if (_checkWinner(row, col)) {
      _winner = _currentPlayer;
    } else {
      _currentPlayer = _currentPlayer == 'X' ? 'O' : 'X';
    }
  }

  void makeComputerMove(String difficulty) {
    switch (difficulty) {
      case 'Easy':
        _makeRandomMove();
        break;
      case 'Medium':
        _blockPlayerWin();
        break;
      case 'Hard':
        _makeBestMove();
        break;
    }
  }

  void _makeRandomMove() {
    var emptyCells = <List<int>>[];
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (_board[i][j] == '') {
          emptyCells.add([i, j]);
        }
      }
    }

    if (emptyCells.isNotEmpty) {
      var random = Random();
      var move = emptyCells[random.nextInt(emptyCells.length)];
      makeMove(move[0], move[1]);
    }
  }

  void _blockPlayerWin() {
    var move = _findBlockingMove();
    if (move != null) {
      makeMove(move[0], move[1]);
    } else {
      _makeRandomMove();
    }
  }

  List<int>? _findBlockingMove() {
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (_board[i][j] == '') {
          _board[i][j] = 'X';
          if (_checkWinner(i, j)) {
            _board[i][j] = '';
            return [i, j];
          }
          _board[i][j] = '';
        }
      }
    }
    return null;
  }

  void _makeBestMove() {
    // Minimax or advanced strategy goes here
    _blockPlayerWin(); // For now, using the medium level strategy
  }

  void resetGame() {
    _resetBoard();
  }
}
