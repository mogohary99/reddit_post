import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';
import 'package:reddit_post/components/user.dart';
import 'package:reddit_post/core/extensions/extensions.dart';
import 'package:reddit_post/models/post_model.dart';

import '../../../core/constants/colors_manager.dart';
import '../views/comments_screen.dart';

class UserAndVideoTitle extends StatelessWidget {
  final PostModel post;
  const UserAndVideoTitle({
    super.key,
    required this.controller, required this.post,
  });

  final CachedVideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         User(name: post.userName,),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>
                    CommentsScreen(controller: controller,postModel: post),
              ),
            );
          },
          child: SizedBox(
            width: MediaQuery.of(context).size.width - 80,
            child:  Text(
              post.title,
              style: context.bodyMedium,
              maxLines: 3,
              textAlign: TextAlign.left,
              softWrap: true,
            ),
          ),
        )
      ],
    );
  }
}

