import 'package:flutter/material.dart';

/// Widget shows the current steps counter of
/// a game.
class GameStepsWidget extends StatefulWidget {
  final int steps;

  const GameStepsWidget({Key? key, required this.steps}) : super(key: key);

  @override
  _GameStepsState createState() => _GameStepsState();
}

class _GameStepsState extends State<GameStepsWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(
      'moves : ${widget.steps}',
      style: Theme.of(context).textTheme.subtitle1,
    );
  }
}
