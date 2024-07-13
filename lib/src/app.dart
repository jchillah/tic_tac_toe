import 'package:flutter/material.dart';
import 'package:tic_tac_toe/src/features/game_tic_tac_toe/presentation/tic_tac_toe.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TicTacToe(),
    );
  }
}
