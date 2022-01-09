import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_puzzle/config/ui.dart';
import 'package:flutter_puzzle/widgets/game/board.dart';
import 'package:flutter_puzzle/widgets/game/material/control.dart';
import 'package:flutter_puzzle/widgets/game/material/steps.dart';
import 'package:flutter_puzzle/widgets/game/material/stopwatch.dart';
import 'package:flutter_puzzle/widgets/game/presenter/main.dart';
import 'package:flutter_puzzle/widgets/game/settings.dart';

class GameMaterialPage extends StatelessWidget {
  /// Maximum size of the board,
  /// in pixels.
  static const kMaxBoardSize = 400.0;

  static const kBoardMargin = 16.0;

  static const kBoardPadding = 4.0;

  final FocusNode _boardFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    final presenter = GamePresenterWidget.of(context);

    final screenSize = MediaQuery.of(context).size;
    final screenWidth =
        MediaQuery.of(context).orientation == Orientation.portrait
            ? screenSize.width
            : screenSize.height;
    final screenHeight =
        MediaQuery.of(context).orientation == Orientation.portrait
            ? screenSize.height
            : screenSize.width;

    final isTallScreen = screenHeight > 800 || screenHeight / screenWidth > 1.9;
    final isLargeScreen = screenWidth > 400;

    final fabWidget = _buildFab(context);
    final boardWidget = _buildBoard(context);
    return OrientationBuilder(builder: (context, orientation) {
      final statusWidget = Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GameStopwatchWidget(
            time: presenter.time ?? 0,
            fontSize: orientation == Orientation.landscape && !isLargeScreen
                ? 56.0
                : 72.0,
          ),
          GameStepsWidget(
            steps: presenter.steps ?? 0,
          ),
        ],
      );

      if (orientation == Orientation.portrait) {
        //
        // Portrait layout
        //
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Flutter Puzzle',
              style: Theme.of(context).textTheme.headline6,
            ),
            actions: [
              InkWell(
                onTap: () {
                  Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => const SettingsPage()))
                      .then((value) {
                    print(value);
                    if (value != null) {
                      presenter.resize(value);
                    }
                  });
                },
                customBorder: const CircleBorder(),
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Icon(
                    Icons.settings,
                    semanticLabel: "Settings",
                  ),
                ),
              ),
            ],
          ),
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 32.0),
                Center(
                  child: statusWidget,
                ),
                const SizedBox(height: 16.0),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: boardWidget,
                  ),
                ),
                isLargeScreen && isTallScreen
                    ? const SizedBox(height: 116.0)
                    : const SizedBox(height: 72.0),
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: fabWidget,
        );
      } else {
        //
        // Landscape layout
        //
        return Scaffold(
          body: SafeArea(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: boardWidget,
                  flex: 3,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      statusWidget,
                      const SizedBox(height: 48.0),
                      fabWidget,
                    ],
                  ),
                  flex: 2,
                ),
              ],
            ),
          ),
        );
      }
    });
  }

  Widget _buildBoard(final BuildContext context) {
    final presenter = GamePresenterWidget.of(context);
    final config = ConfigUiContainer.of(context);
    final background = Theme.of(context).brightness == Brightness.dark
        ? Colors.black54
        : Colors.black12;
    return Center(
      child: Container(
        margin: const EdgeInsets.all(kBoardMargin),
        padding: const EdgeInsets.all(kBoardPadding),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final puzzleSize = min(
              min(
                constraints.maxWidth,
                constraints.maxHeight,
              ),
              kMaxBoardSize - (kBoardMargin + kBoardPadding) * 2,
            );

            return RawKeyboardListener(
              autofocus: true,
              focusNode: _boardFocus,
              onKey: (event) {
                if ((event is! RawKeyDownEvent)) {
                  return;
                }

                int offsetY = 0;
                int offsetX = 0;
                switch (event.logicalKey.keyId) {
                  case 0x100070052: // arrow up
                    offsetY = 1;
                    break;
                  case 0x100070050: // arrow left
                    offsetX = 1;
                    break;
                  case 0x10007004f: // arrow right
                    offsetX = -1;
                    break;
                  case 0x100070051: // arrow down
                    offsetY = -1;
                    break;
                  default:
                    return;
                }
                final tapPoint =
                    presenter.board!.blank + Point(offsetX, offsetY);
                if (tapPoint.x < 0 ||
                    tapPoint.x >= presenter.board!.size ||
                    tapPoint.y < 0 ||
                    tapPoint.y >= presenter.board!.size) {
                  return;
                }

                presenter.tap(point: tapPoint);
              },
              child: BoardWidget(
                board: presenter.board!,
                size: puzzleSize,
                onTap: (point) {
                  presenter.tap(point: point);
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildFab(final BuildContext context) {
    final presenter = GamePresenterWidget.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          width: 48,
          height: 48,
          child: Material(
            elevation: 0.0,
            color: Colors.transparent,
            shape: const CircleBorder(),
            child: InkWell(
              onTap: () {
                presenter.reset();
              },
              customBorder: const CircleBorder(),
              child: const Icon(
                Icons.refresh,
                semanticLabel: "Reset",
              ),
            ),
          ),
        ),
        const SizedBox(width: 16.0),
        GamePlayStopButton(
          isPlaying: presenter.isPlaying(),
          onTap: () {
            presenter.playStop();
          },
        ),
      ],
    );
  }
}
