import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:reddit_post/components/replay_card.dart';
import 'package:reddit_post/controller/post_cubit/post_cubit.dart';
import 'package:reddit_post/controller/post_cubit/post_state.dart';
import 'package:reddit_post/models/comment_model.dart';
import 'package:reddit_post/models/replay_model.dart';
import 'package:reddit_post/views/add_replay_screen.dart';

import '../core/constants/assets_manager.dart';
import '../core/constants/colors_manager.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'my_popup_menu_button.dart';

class CommentCard extends StatefulWidget {
  final CommentModel commentModel;

  const CommentCard({
    super.key,
    required this.commentModel,
  });

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  bool colabsed = true;

  @override
  Widget build(BuildContext context) {
    CommentModel commentModel = widget.commentModel;
    if (colabsed) {
      return GestureDetector(
        onTap: () {
          setState(() {
            colabsed = false;
          });
        },
        child: CollapsedCard(
          userName: widget.commentModel.userName,
          time: widget.commentModel.time,
          comment: widget.commentModel.comment,
        ),
      );
    }
    return GestureDetector(
      onTap: () {
        setState(() {
          colabsed = true;
        });
      },
      child: Container(
        color: AppColors.blackLight,
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
        margin: const EdgeInsets.only(bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  AppIcons.redditIcon1,
                  width: 28,
                  height: 28,
                ),
                const SizedBox(width: 8),
                Text(
                  commentModel.userName,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  timeago.format(commentModel.time, locale: 'en_short'),
                  style: const TextStyle(
                    color: AppColors.grey,
                    fontSize: 12,
                    //fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            const SizedBox(height: 5),
            Text(
              commentModel.comment,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white.withOpacity(0.8),
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 5),
            Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  MyBopupMenuButton(
                    userId: widget.commentModel.userId,
                    id: widget.commentModel.id,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddReplayScreen(
                            comment: widget.commentModel.comment,
                            id: widget.commentModel.id,
                            time: widget.commentModel.time,
                            userName: widget.commentModel.userImage,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.blackLight,
                    ),
                    icon: const Icon(
                      Icons.replay,
                      color: Colors.grey,
                      size: 18,
                    ),
                    label: const Text(
                      'Reply',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  VotesButtons(),
                ],
              ),
            ),
            BlocBuilder<PostCubit, PostState>(
              builder: (context, state) {
                List<ReplayModel> replies =
                    PostCubit.get(context).getRepliesOfId(
                  id: commentModel.id,
                );
                return ListView.builder(
                  itemCount: replies.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ReplayCard(
                      replayModel: replies[index],
                      id: widget.commentModel.id,
                    );
                  },
                );
              },
            ),
            // ReplayCard(),
          ],
        ),
      ),
    );
  }
}

class CollapsedCard extends StatelessWidget {
  final String userName;
  final DateTime time;
  final String comment;

  const CollapsedCard({
    super.key,
    required this.userName,
    required this.time,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.blackLight,
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          SvgPicture.asset(
            AppIcons.redditIcon1,
            width: 28,
            height: 28,
          ),
          const SizedBox(width: 8),
          Text(
            userName,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            timeago.format(time, locale: 'en_short'),
            style: const TextStyle(
              color: AppColors.grey,
              fontSize: 12,
              //fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Text(
              '. ${comment}',
              style: const TextStyle(
                color: AppColors.grey,
                fontSize: 14,
                //fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }
}

class VotesButtons extends StatefulWidget {
  const VotesButtons({super.key});

  @override
  State<VotesButtons> createState() => _VotesButtonsState();
}

class _VotesButtonsState extends State<VotesButtons> {
  bool up = false;
  bool down = false;
  int numOfVotes = Random().nextInt(900);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            if (up) {
              up = false;
              numOfVotes--;
              setState(() {});
            } else if (up == false && down == false) {
              up = true;
              numOfVotes++;
              setState(() {});
            } else if (up == false && down == true) {
              up = true;
              down = false;
              numOfVotes += 2;
              setState(() {});
            }
          },
          icon: SvgPicture.asset(
            up ? AppIcons.topIcon : AppIcons.topOutIcon,
            width: 20,
            color: up ? Colors.red : AppColors.grey,
          ),
        ),
        Text(
          numOfVotes.toString(),
          style: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w900,
            fontSize: 12,
          ),
        ),
        IconButton(
          onPressed: () {
            if (down) {
              down = false;
              numOfVotes++;
              setState(() {});
            } else if (up == false && down == false) {
              down = true;
              numOfVotes--;
              setState(() {});
            } else if (up == true && down == false) {
              up = false;
              down = true;
              numOfVotes -= 2;
              setState(() {});
            }
          },
          icon: SvgPicture.asset(
            down ? AppIcons.downIcon : AppIcons.downOutIcon,
            width: 25,
            height: 20,
            color: down ? Colors.green : AppColors.grey,
          ),
        ),
      ],
    );
  }
}
