import 'package:flutter/material.dart';

class DifficultySettings extends StatelessWidget {
  final String currentDifficulty;
  final ValueChanged<String> onDifficultyChanged;

  const DifficultySettings({
    super.key,
    required this.currentDifficulty,
    required this.onDifficultyChanged,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (String value) {
        onDifficultyChanged(value);
      },
      itemBuilder: (BuildContext context) {
        return ['Easy', 'Medium', 'Hard'].map((String choice) {
          return PopupMenuItem<String>(
            value: choice,
            child: Text(choice),
          );
        }).toList();
      },
    );
  }
}
