import 'package:flutter/material.dart';
import 'package:tic_tac_toe/src/features/game_tic_tac_toe/presentation/difficulty_settings.dart';
import 'package:tic_tac_toe/src/features/game_tic_tac_toe/presentation/game_logic.dart';

class TicTacToe extends StatefulWidget {
  const TicTacToe({super.key});

  @override
  TicTacToeState createState() => TicTacToeState();
}

class TicTacToeState extends State<TicTacToe> {
  final GameLogic _game = GameLogic();
  String _difficulty = 'Medium'; // Default difficulty level

  void _handleTap(int row, int col) {
    setState(() {
      _game.makeMove(row, col);
      if (_game.winner == null && _game.currentPlayer == 'O') {
        _game.makeComputerMove(_difficulty);
      }
      if (_game.winner != null) {
        _showWinnerDialog(_game.winner!);
      }
    });
  }

  void _showWinnerDialog(String winner) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Spiel beendet'),
          content: Text('Spieler $winner hat gewonnen!'),
          actions: [
            TextButton(
              child: const Text('Neues Spiel'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _game.resetGame();
                });
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic Tac Toe'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _game.resetGame();
              });
            },
          ),
          DifficultySettings(
            currentDifficulty: _difficulty,
            onDifficultyChanged: (String value) {
              setState(() {
                _difficulty = value;
              });
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _game.board
            .asMap()
            .entries
            .map((entry) => _buildRow(entry.key, entry.value))
            .toList(),
      ),
    );
  }

  Widget _buildRow(int row, List<String> cells) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: cells
          .asMap()
          .entries
          .map((entry) => _buildCell(row, entry.key, entry.value))
          .toList(),
    );
  }

  Widget _buildCell(int row, int col, String value) {
    return GestureDetector(
      onTap: () => _handleTap(row, col),
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(),
        ),
        child: Center(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
