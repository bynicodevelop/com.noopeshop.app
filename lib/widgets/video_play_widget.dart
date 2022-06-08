import 'package:com_noopeshop_app/models/feed_model.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final FeedModel feedModel;

  const VideoPlayerWidget({
    Key? key,
    required this.feedModel,
  }) : super(key: key);

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset(
      widget.feedModel.media,
    )..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
        _controller.play();
      });

    _controller.setLooping(true);
  }

  @override
  Widget build(BuildContext context) {
    return VideoPlayer(_controller);
  }
}
