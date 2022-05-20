import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class IframeYoutubePlayer extends StatefulWidget {
  final String? youtubeUrl;
  const IframeYoutubePlayer(this.youtubeUrl);

  @override
  State<IframeYoutubePlayer> createState() => _IframeYoutubePlayerState();
}

class _IframeYoutubePlayerState extends State<IframeYoutubePlayer> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayerController.convertUrlToId(widget.youtubeUrl!)!,
      params: const YoutubePlayerParams(
        loop: false,
        color: 'transparent',
        desktopMode: true,
        strictRelatedVideos: true,
        showFullscreenButton: !kIsWeb,
      ),
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final screenSize= MediaQuery.of(context).size;
    return SizedBox(
      height: kIsWeb ? screenSize.height / 1.13 : screenSize.height,
      width: screenSize.width,
      child: YoutubePlayerControllerProvider(
        controller: _controller,
        child: YoutubePlayerIFrame(
          controller: _controller,
        ),
      ),
    );
  }
}

