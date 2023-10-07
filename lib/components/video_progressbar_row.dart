import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/colors_manager.dart';

class VideoProgressRow extends StatefulWidget {
  final CachedVideoPlayerController controller;

  const VideoProgressRow({super.key, required this.controller});

  @override
  State<VideoProgressRow> createState() => _VideoProgressRowState();
}

class _VideoProgressRowState extends State<VideoProgressRow> {
  @override
  Widget build(BuildContext context) {
    CachedVideoPlayerController controller = widget.controller;
    bool isMuted = controller.value.volume == 0;
    return Row(
      children: [
        if (controller.value.isInitialized)
          GestureDetector(
            onTap: () => controller.value.isPlaying
                ? controller.pause()
                : controller.play(),
            child: Icon(
              controller.value.isPlaying ? Icons.stop : Icons.play_arrow,
              color: Colors.white,
              size: 30,
            ),
          ),
        Expanded(
          child: VideoProgressIndicator(
            controller,
            allowScrubbing: true,
            colors: const VideoProgressColors(
              playedColor: AppColors.white,
              bufferedColor: Colors.black12,
            ),
          ),
        ),
        const SizedBox(width: 10),
        if (controller.value.isInitialized)
          Text(
            formatDuration(controller.value.duration),
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        const SizedBox(width: 10),
        if (controller.value.isInitialized)
          GestureDetector(
            onTap: () => controller.setVolume(isMuted ? 1 : 0),
            child: Icon(
              isMuted ? Icons.volume_off : Icons.volume_up,
              color: Colors.white,
              size: 30,
            ),
          ),
      ],
    );
  }

  String formatDuration(Duration duration) {
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }
}
