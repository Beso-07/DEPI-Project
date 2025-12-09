import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PlayYoutubeScreen extends StatefulWidget {
  final String url;

  const PlayYoutubeScreen({super.key, required this.url});

  @override
  State<PlayYoutubeScreen> createState() => _PlayYoutubeScreenState();
}

class _PlayYoutubeScreenState extends State<PlayYoutubeScreen> {
  late YoutubePlayerController controller;

  @override
  void initState() {
    super.initState();

    final videoId = YoutubePlayer.convertUrlToId(widget.url) ?? "";

    controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        controlsVisibleAtStart: true,
        disableDragSeek: false,
        enableCaption: false,
        forceHD: false,
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: controller,
        showVideoProgressIndicator: true,
      ),
      builder: (context, player) {
        return Scaffold(
          appBar: AppBar(title: const Text("مشاهدة القصة")),
          body: Padding(
            padding: const EdgeInsets.all(12),
            child: player,
          ),
        );
      },
    );
  }
}
