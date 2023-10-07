import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:reddit_post/components/comment_card.dart';
import 'package:reddit_post/models/replay_model.dart';
import 'package:reddit_post/views/add_replay_screen.dart';

import '../controller/post_cubit/post_cubit.dart';
import '../controller/post_cubit/post_state.dart';
import '../core/constants/assets_manager.dart';
import '../core/constants/colors_manager.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'my_popup_menu_button.dart';

class ReplayCard extends StatefulWidget {
  final String id;
  final ReplayModel replayModel;

  const ReplayCard({
    super.key,
    required this.replayModel, required this.id,
  });

  @override
  State<ReplayCard> createState() => _ReplayCardState();
}

class _ReplayCardState extends State<ReplayCard> {
  bool colabsed = true;

  @override
  Widget build(BuildContext context) {
    ReplayModel replayModel = widget.replayModel;
    if (colabsed) {
      return GestureDetector(
        onTap: () {
          setState(() {
            colabsed = false;
          });
        },
        child: CollapsedCard(
          userName: widget.replayModel.userName,
          comment: widget.replayModel.comment,
          time: widget.replayModel.time,
        ),
      );
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          colabsed = true;
        });
      },
      child: Column(
        children: [
          Container(
            //color: AppColors.grey,
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(width: 1.0, color: Colors.grey.shade800),
              ),
            ),
            child: Container(
              color: AppColors.blackLight,
              margin: const EdgeInsets.only(left: 1),
              padding: const EdgeInsets.only(left: 20),
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
                        widget.replayModel.userName,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        timeago.format(replayModel.time, locale: 'en_short'),
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
                    widget.replayModel.comment,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.8),
                      fontWeight: FontWeight.w600,
                    ),
                    // maxLines: 3,
                    softWrap: true,
                    //overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(height: 5),
                  Align(
                    alignment: Alignment.centerRight,
                    child: FittedBox(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          MyBopupMenuButton(
                            id: widget.replayModel.id,
                            userId: widget.replayModel.userId,
                            baseId: widget.id,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => AddReplayScreen(
                                    userName: widget.replayModel.userName,
                                    time: widget.replayModel.time,
                                    id: widget.replayModel.id,
                                    comment: widget.replayModel.comment,
                                  ),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.blackLight,
                            ),
                            child: const Icon(
                              Icons.replay,
                              color: Colors.grey,
                              size: 18,
                            ),
                          ),
                          const VotesButtons(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          BlocBuilder<PostCubit, PostState>(
            builder: (context, state) {
              List<ReplayModel> replies = PostCubit.get(context).getRepliesOfId(
                id: widget.replayModel.id,
              );
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(width: 1.0, color: Colors.grey.shade800),
                  ),
                ),
                child: ListView.builder(
                  itemCount: replies.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                      color: Colors.grey.shade800,
                      margin: const EdgeInsets.only(
                        bottom: 10,
                      ),
                      child: Container(
                        color: AppColors.blackLight,
                        margin: const EdgeInsets.only(left: 0.3),
                        padding: const EdgeInsets.only(left: 20),
                        child: ReplayCard(
                          replayModel: replies[index],
                          id: widget.id,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
