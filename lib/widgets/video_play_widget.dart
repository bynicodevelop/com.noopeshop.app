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
        setState(() {});
        _controller.play();
      });

    _controller.setLooping(true);
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? VideoPlayer(
            _controller,
          )
        : const SizedBox.shrink();
  }
}
