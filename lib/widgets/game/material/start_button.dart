import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// Widget that can start / stop
/// a game.
class GamePlayStopButton extends StatefulWidget {
  final bool isPlaying;

  final Function()? onTap;

  final Color? btnColor;

  GamePlayStopButton({required this.isPlaying, this.onTap, this.btnColor});

  @override
  _GamePlayStopButtonState createState() => _GamePlayStopButtonState();
}

class _GamePlayStopButtonState extends State<GamePlayStopButton>
    with TickerProviderStateMixin {
  AnimationController? controller;
  Animation<double>? animation;

  @override
  void initState() {
    controller = AnimationController(
      duration: const Duration(milliseconds: 140),
      vsync: this,
    );
    animation = CurvedAnimation(
      parent: controller!,
      curve: Curves.easeInOut,
    );
    animation!.addListener(() => setState(() {}));

    super.initState();

    // Don't play the initial animation.
    final isPlaying = widget.isPlaying;
    controller!.value = isPlaying ? 1.0 : 0.0;
  }

  @override
  void didUpdateWidget(GamePlayStopButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    final wasPlaying = oldWidget.isPlaying;
    final isPlaying = widget.isPlaying;
    if (isPlaying != wasPlaying) {
      _performSetIsPlaying(isPlaying);
    }
  }

  void _performSetIsPlaying(bool isPlaying) {
    if (isPlaying) {
      controller!.forward();
    } else {
      controller!.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final animRatioPlay = _range(1.0 - animation!.value, begin: 0.0, end: 1.0);
    final animRatioStop = _range(animation!.value, begin: 0.0, end: 1.0);

    // Calculate the background color of the FAB.
    final backgroundColorAccent =
        theme.colorScheme.secondary.withOpacity(animRatioPlay);
    final backgroundColorCard = theme.cardColor.withOpacity(animRatioStop);
    final backgroundColor =
        Color.alphaBlend(backgroundColorAccent, backgroundColorCard);

    return FloatingActionButton.extended(
      heroTag: 'action',
      backgroundColor: widget.isPlaying ? backgroundColor : widget.btnColor,
      tooltip: widget.isPlaying ? "Stop" : "Play",
      onPressed: () => widget.onTap?.call(),
      label: Row(
        children: [
          Stack(
            children: <Widget>[
              Opacity(
                opacity: animRatioPlay,
                child: Transform.rotate(
                  angle: animation!.value * pi / 2.0,
                  child: Row(
                    children: [
                      Text(
                        'Start',
                        style: TextStyle(color: theme.iconTheme.color),
                      ),
                      Icon(
                        Icons.play_arrow,
                        color: theme.iconTheme.color,
                      ),
                    ],
                  ),
                ),
              ),
              Opacity(
                opacity: animRatioStop,
                child: Transform.rotate(
                  angle: animation!.value / 100.0,
                  child: Row(
                    children: [
                      Icon(
                        Icons.stop,
                        color: theme.iconTheme.color,
                      ),
                      Text(
                        'Stop',
                        style: TextStyle(color: theme.iconTheme.color),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  double _range(double v, {required double begin, required double end}) =>
      max(min(v, end), begin);

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }
}
