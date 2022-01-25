import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class MusicPage extends StatefulWidget {
  const MusicPage({Key? key}) : super(key: key);

  @override
  _MusicPageState createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
  //Audio player
  AudioPlayer? advancedPlayer;
  late AudioCache audioCache;

  @override
  void initState() {
    super.initState();

    setState(() {
      advancedPlayer = AudioPlayer();
      audioCache = AudioCache(fixedPlayer: advancedPlayer);
    });
  }

  @override
  void dispose() {
    super.dispose();
    advancedPlayer!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  resetTime() async {
    advancedPlayer!.stop();

    if (advancedPlayer!.playerId != null) {
      audioCache.loop(
        "music.mp3",
      );
    } else {
      advancedPlayer!.stop();
    }

    if (0 < 1) {
      advancedPlayer!.stop();
    }
  }
}
