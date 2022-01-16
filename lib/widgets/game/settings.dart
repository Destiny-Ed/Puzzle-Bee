import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_puzzle/config/ui.dart';
import 'package:flutter_puzzle/data/board.dart';
import 'package:flutter_puzzle/links.dart';
import 'package:flutter_puzzle/provider/auth_provider.dart';
import 'package:flutter_puzzle/widgets/game/board.dart';
import 'package:share/share.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool? _isDark;
  @override
  Widget build(BuildContext context) {
    final config = ConfigUiContainer.of(context);

    _isDark = config.useDarkTheme == null
        ? false
        : config.useDarkTheme == true
            ? true
            : false;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Settings'),
        actions: [
          GestureDetector(
            onTap: () {
              AuthenticationProvider().logOut(context);
            },
            child: const Padding(
              padding: EdgeInsets.all(10),
              child: Icon(Icons.exit_to_app),
            ),
          )
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  ///Theme Toggle

                  CheckboxListTile(
                    contentPadding: const EdgeInsets.all(0),
                    value: _isDark,
                    onChanged: (value) {
                      bool shouldUseDarkTheme;
                      if (config.useDarkTheme == null) {
                        shouldUseDarkTheme = true;
                      } else if (config.useDarkTheme == true) {
                        shouldUseDarkTheme = false;
                      } else {
                        shouldUseDarkTheme = true;
                      }
                      config.setUseDarkTheme(shouldUseDarkTheme, save: true);
                    },
                    title: const Text('Select Theme'),
                    subtitle: Text(config.useDarkTheme == null
                        ? 'Switch between dark and light theme'
                        : config.useDarkTheme == true
                            ? 'Switch to Light theme'
                            : 'Switch to Dark theme'),
                  ),

                  const Divider(),

                  ListTile(
                    title: const Text('Share App'),
                    subtitle: const Text('Play Puzzle Bee with friends'),
                    onTap: () {
                      Share.share(
                          "Hey, This is how I challenge and keep my mind active $APP_URL");
                    },
                  ),

                  const Divider(),

                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Select Difficulty',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),

                  // /Easy
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Easy',
                    ),
                  ),

                  Row(
                    children: <Widget>[
                      const SizedBox(width: 8),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: createBoard(size: 2),
                        ),
                      ),
                      Expanded(child: createBoard(size: 3)),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: createBoard(size: 4),
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                  const Divider(),

                  // /Medium
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Mediun (Coming Soon)',
                    ),
                  ),

                  const Divider(),

                  // ///Hard
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Hard (Comming Soon)',
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget createBoard({int? size}) => Center(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pop(size);
          },
          child: Column(
            children: <Widget>[
              Semantics(
                excludeSemantics: true,
                child: Align(
                  alignment: Alignment.center,
                  child: Text('${size}x$size'),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.black54
                      : Colors.black12,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Semantics(
                  label: '${size}x$size',
                  child: LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints constraints) {
                      final puzzleSize = min(
                        min(
                          constraints.maxWidth,
                          constraints.maxHeight,
                        ),
                        96.0,
                      );

                      return Semantics(
                        excludeSemantics: true,
                        child: BoardWidget(
                          board: Board.createNormal(size!),
                          onTap: null,
                          showNumbers: false,
                          size: puzzleSize,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
