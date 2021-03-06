import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_puzzle/config/ui.dart';
import 'package:flutter_puzzle/links.dart';
import 'package:flutter_puzzle/main.dart';
import 'package:flutter_puzzle/utils/url.dart';
import 'package:flutter_puzzle/widgets/game/board.dart';
import 'package:flutter_puzzle/widgets/game/material/start_button.dart';
import 'package:flutter_puzzle/widgets/game/material/moves.dart';
import 'package:flutter_puzzle/widgets/game/material/stopwatch.dart';
import 'package:flutter_puzzle/widgets/game/presenter/presenter.dart';
import 'package:flutter_puzzle/widgets/game/settings.dart';

class GameMaterialPage extends StatefulWidget {
  /// Maximum size of the board,
  /// in pixels.
  static const kMaxBoardSize = 400.0;

  static const kBoardMargin = 16.0;

  static const kBoardPadding = 4.0;

  @override
  State<GameMaterialPage> createState() => _GameMaterialPageState();
}

class _GameMaterialPageState extends State<GameMaterialPage> {
  final FocusNode _boardFocus = FocusNode();

  String name = '';

  @override
  void initState() {
    super.initState();
    // if (!kIsWeb) {
    //   if (Platform.isAndroid || Platform.isIOS) {
    //     Amplify.Auth.fetchUserAttributes().then((value) {
    //       for (int i = 0; i < value.length; i++) {
    //         final data = value[i];
    //         if (data.userAttributeKey == 'name') {
    //           setState(() {
    //             name = "Welcome ${data.value}";
    //           });
    //         }
    //       }
    //     });
    //   }
    // }
  }

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

    final boardWidget = _buildBoard(context);

    ///Check if board is null before applying app color
    final mainColor = presenter.board == null
        ? const HSLColor.fromAHSL(1, 4.0 * 3.0, 0.7, 0.5).toColor()
        : HSLColor.fromAHSL(
                1,
                (360 / presenter.board!.chips.length) *
                    presenter.board!.chips.last.number,
                0.7,
                0.5)
            .toColor();
    return OrientationBuilder(builder: (context, orientation) {
      final statusWidget = Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
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

      final actionButton = GestureDetector(
        onTap: () {
          launchUrl(url: APP_URL);
        },
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Image.asset('assets/playstore.png', width: 45),
              const Text('Download App')
            ],
          ),
        ),
      );

      if (orientation == Orientation.portrait) {
        //
        // Portrait layout
        //

        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: mainColor,
            leading: GestureDetector(
              onTap: () {
                Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => SettingsPage(mainColor)))
                    .then((value) {
                  if (value != null) {
                    ///Save size to SF
                    presenter.resize(value);
                  }
                });
              },
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(
                  Icons.settings,
                  semanticLabel: "Settings",
                ),
              ),
            ),
            title: const Text(
              'Puzzle Bee',
            ),
            actions: [
              kIsWeb
                  ? actionButton
                  : !Platform.isAndroid && !Platform.isIOS
                      ? actionButton
                      : const Text(''),
            ],
          ),
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 20.0),
                Center(
                  child: Text(
                    name,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
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
          floatingActionButton: _buildFab(context, mainColor),
        );
      } else {
        AppBar appBar = AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            GestureDetector(
              onTap: () {
                launchUrl(url: APP_URL);
              },
              child: Container(
                decoration: BoxDecoration(
                    color: mainColor, borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.all(10.0),
                margin: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Image.asset('assets/playstore.png', width: 45),
                    const Text('Download App')
                  ],
                ),
              ),
            ),
          ],
        );
        //
        // Landscape layout
        //
        return Scaffold(
          appBar: kIsWeb
              ? appBar
              : !Platform.isAndroid && !Platform.isIOS
                  ? appBar
                  : null,
          body: SafeArea(
            child: Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => SettingsPage(mainColor)))
                        .then((value) {
                      if (value != null) {
                        ///SAVE SIZE TO SF
                        presenter.resize(value);
                      }
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: CircleAvatar(
                      backgroundColor: mainColor,
                      child: const Icon(
                        Icons.settings,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: boardWidget,
                  flex: 2,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      statusWidget,
                      const SizedBox(height: 48.0),
                      _buildFab(context, mainColor),
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
      child: presenter.board == null
          ? const CircularProgressIndicator()
          : Container(
              margin: const EdgeInsets.all(GameMaterialPage.kBoardMargin),
              padding: const EdgeInsets.all(GameMaterialPage.kBoardPadding),
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
                    GameMaterialPage.kMaxBoardSize -
                        (GameMaterialPage.kBoardMargin +
                                GameMaterialPage.kBoardPadding) *
                            2,
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

  Widget _buildFab(final BuildContext context, Color color) {
    final presenter = GamePresenterWidget.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        FloatingActionButton.extended(
            heroTag: 'shuffle',
            backgroundColor: color,
            onPressed: () {
              presenter.reset();
            },
            label: const Text('Shuffle')),
        const SizedBox(width: 16.0),
        GamePlayStopButton(
          isPlaying: presenter.isPlaying(),
          onTap: () {
            presenter.playStop();
          },
          btnColor: color,
        ),
      ],
    );
  }
}
