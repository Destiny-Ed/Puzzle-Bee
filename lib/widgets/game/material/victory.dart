import 'package:flutter/material.dart';
import 'package:flutter_puzzle/data/result.dart';
import 'package:flutter_puzzle/links.dart';
import 'package:flutter_puzzle/play_games.dart';
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
       FlatButton(
        child:  Text("Share"),
        onPressed: () {
          Share.share("I have solved the Flutter Puzzle's "
              "${result.size}x${result.size} puzzle in $timeFormatted "
              "with just ${result.steps} steps! Check it out: $URL_REPOSITORY");
        },
      ),
       FlatButton(
        child: const  Text("Close"),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    ];

    // if (PlayGamesContainer.of(context).isSupported) {
    //   actions.insert(
    //     0,
    //      FlatButton(
    //       child:  const Text("Leaderboard"),
    //       onPressed: () {
    //         final playGames = PlayGamesContainer.of(context);
    //         playGames.showLeaderboard(
    //           key: PlayGames.getLeaderboardOfSize(result.size),
    //         );
    //       },
    //     ),
    //   );
    // }

    return AlertDialog(
      title: Center(
        child: Text(
          "Congratulations!",
          style: Theme.of(context).textTheme.headline5,
        ),
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
                    'Steps:',
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
