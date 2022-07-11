import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'app_video.dart';

class AppVideoPlayer extends StatefulWidget {
  final String? url;

  const AppVideoPlayer({Key? key, this.url}) : super(key: key);

  @override
  _AppVideoPlayerState createState() => _AppVideoPlayerState();
}

class _AppVideoPlayerState extends State<AppVideoPlayer> {
  VideoPlayerController? videoPlayerController;
  ChewieController? chewieController;

  @override
  void initState() {
    initializePlayer();
    super.initState();
  }

  Future<void> initializePlayer() async {
    String url = widget.url ?? '';
    String urlPrefix = url.split('/').first;
    bool isRemote = urlPrefix.contains('http');
    if (isRemote) {
      videoPlayerController = VideoPlayerController.network(url);
    } else {
      videoPlayerController = VideoPlayerController.file(File(url));
    }

    await videoPlayerController!.initialize();
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController!,
      showOptions: false,
      materialProgressColors: ChewieProgressColors(
        bufferedColor: const Color.fromRGBO(200, 200, 200, 0.65),
        playedColor: const Color(0xff67C23A),
      ),
    );
    setState(() {});
  }

  @override
  void dispose() {
    videoPlayerController?.dispose();
    chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (chewieController != null &&
        chewieController!.videoPlayerController.value.isInitialized) {
      return Chewie(
        controller: chewieController!,
      );
    }
    return AppVideo(
      url: widget.url ?? '',
      coverFit: BoxFit.fitWidth,
      coverColor: Colors.black,
      coverCenterIcon: const SizedBox(
        width: 30,
        height: 30,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget buildOptionItem(
    String label, {
    Function()? onTap,
    TextStyle? textStyle,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        height: 50,
        color: Colors.white,
        child: Center(
          child: Text(
            label,
            style: textStyle,
          ),
        ),
      ),
    );
  }
}
