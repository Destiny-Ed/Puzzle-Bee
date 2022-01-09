import 'package:flutter/material.dart';
import 'package:flutter_puzzle/data/result.dart';
import 'package:flutter_puzzle/links.dart';
import 'package:share/share.dart';

import '../format.dart';

class GameVictoryDialog extends StatelessWidget {
  final Result result;

  final String Function(int) timeFormatter;

  GameVictoryDialog({
    required this.result,
    this.timeFormatter = formatElapsedTime,
  });

  @override
  Widget build(BuildContext context) {
    final timeFormatted = timeFormatter(result.time);
    final actions = <Widget>[
      GestureDetector(
        onTap: () {
          Share.share("I successfully solved the Flutter Puzzle's "
              "${result.size}x${result.size} puzzle in $timeFormatted "
              "with just ${result.steps} moves... Challenge me! $APP_URL");
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.blue),
            // color: Colors.blue,
          ),
          child: const Text("Post"),
        ),
      ),
      GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.blue,
          ),
          child: const Text("Play Again"),
        ),
      ),
    ];

    return AlertDialog(
      title: Center(
        // child: Text(
        //   "Congratulations!",
        //   style: Theme.of(context).textTheme.headline5,
        // ),
        child: Image.asset('artwork/congrat.png', width: 100),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
              "You've successfuly completed the ${result.size}x${result.size} puzzle"),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Time:',
                    style: Theme.of(context).textTheme.caption,
                  ),
                  Text(
                    timeFormatted,
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                          color: Theme.of(context).textTheme.bodyText1!.color,
                        ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Moves:',
                    style: Theme.of(context).textTheme.caption,
                  ),
                  Text(
                    '${result.steps}',
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                          color: Theme.of(context).textTheme.bodyText1!.color,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      actions: actions,
    );
  }
}
