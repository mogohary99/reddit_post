import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sliding_box/flutter_sliding_box.dart';
import 'package:reddit_post/models/post_model.dart';

import '../components/best_comments_button.dart';
import '../components/botom_sheet_body.dart';
import '../components/comment_card.dart';
import '../components/post_title_card_at_comment_screen.dart';
import '../core/constants/colors_manager.dart';
import 'add_comment_screen.dart';

class CommentsScreen extends StatefulWidget {
  final CachedVideoPlayerController controller;
  final PostModel postModel;

  const CommentsScreen(
      {super.key, required this.controller, required this.postModel});

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  late BoxController boxController;

  bool slideValue = false;
  int num = 0;

  @override
  void initState() {
    super.initState();
    boxController = BoxController();
    boxController.addListener(() {
      if (slideValue && num == 0) {
        boxController.hideBox().then((value) {
          num++;
          Navigator.pop(context);
        });
      }
    });
  }

  @override
  void dispose() {
    boxController.dispose();
    super.dispose();
  }

  ScrollController sc = ScrollController();
  bool downScroll = false;

  @override
  Widget build(BuildContext context) {
    bool isMuted = widget.controller.value.volume == 0;
    print(downScroll);
    return Scaffold(
      body: Stack(
        children: [
          SlidingBox(
            controller: boxController,
            minHeight: 200,
            color: const Color(0xff0A0A0A),
            maxHeight: (widget.controller.value.aspectRatio *
                    MediaQuery.of(context).size.height) -
                40 -
                MediaQuery.of(context).size.height,
            onBoxSlide: (i) {
              print(i);
              if (i <= 0.7 && !slideValue) {
                slideValue = true;
              }
            },
            body: const BottomSheetBody(),
            backdrop: Backdrop(
                moving: false,
                body: Container(
                  color: Colors.black,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Hero(
                            tag: 'kkk',
                            child: widget.controller.value.isInitialized
                                ? AspectRatio(
                                    aspectRatio:
                                        widget.controller.value.aspectRatio,
                                    child: CachedVideoPlayer(widget.controller))
                                : const CircularProgressIndicator(),
                          ),
                          Positioned(
                            bottom: 10,
                            right: 10,
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    widget.controller.value.isPlaying
                                        ? widget.controller.pause()
                                        : widget.controller.play();
                                    setState(() {});
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: Colors.black26,
                                    radius: 16,
                                    child: Icon(
                                      widget.controller.value.isPlaying
                                          ? Icons.stop
                                          : Icons.play_arrow,
                                      color: Colors.white,
                                      size: 25,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5,),
                                GestureDetector(
                                  onTap: () {
                                    widget.controller
                                        .setVolume(isMuted ? 1 : 0);
                                    setState(() {});
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: Colors.black26,
                                    radius: 16,
                                    child: Icon(
                                      isMuted
                                          ? Icons.volume_off
                                          : Icons.volume_up,
                                      color: Colors.white,
                                      size: 25,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AddCommentScreen(
                      postModel: widget.postModel,
                    ),
                  ),
                );
              },
              child: Container(
                color: AppColors.blackLight,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  decoration: BoxDecoration(
                      color: Color(0xff1E1E1E),
                      borderRadius: BorderRadius.circular(5)),
                  child: const Text(
                    'Add a comment',
                    style: TextStyle(
                        color: AppColors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
