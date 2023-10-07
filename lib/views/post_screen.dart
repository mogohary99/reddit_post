import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';
import 'package:reddit_post/models/post_model.dart';

import '../components/top_appbar.dart';
import '../components/user_and_video_title.dart';
import '../components/video_progressbar_row.dart';
import '../components/vote_comment_share_buttons.dart';

class PostScreen extends StatefulWidget {
  final PostModel post;

  const PostScreen({super.key, required this.post});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  bool show = true;
  late CachedVideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    controller = CachedVideoPlayerController.asset(widget.post.url)
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then(
        (value) => controller.play(),
      );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          show = !show;
        });
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Hero(
                tag: 'kkk',
                child: controller.value.isInitialized
                    ? AspectRatio(
                        aspectRatio: controller.value.aspectRatio,
                        child: CachedVideoPlayer(controller))
                    : const CircularProgressIndicator(),
              ),
            ),
            Visibility(
              visible: show,
              child: Positioned(
                top: 40,
                right: 20,
                left: 20,
                bottom: 10,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const TopAppBar(),
                    const Spacer(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        UserAndVideoTitle(
                          controller: controller,
                          post: widget.post,
                        ),
                        const Spacer(),
                        VoteCommentShareButtons(
                          controller: controller,
                          postModel: widget.post,
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    VideoProgressRow(controller: controller),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
