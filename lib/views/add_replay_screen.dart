import 'package:flutter/material.dart';
import 'package:reddit_post/main.dart';
import 'package:reddit_post/models/comment_model.dart';
import 'package:reddit_post/models/replay_model.dart';

import '../controller/post_cubit/post_cubit.dart';
import '../core/constants/colors_manager.dart';
import 'package:timeago/timeago.dart' as timeago;

class AddReplayScreen extends StatefulWidget {
 // final CommentModel? commentModel;
  final String id;
  final String comment;
  final String userName;
  final DateTime time;

  const AddReplayScreen({super.key, required this.id, required this.comment, required this.userName, required this.time,  });

  @override
  State<AddReplayScreen> createState() => _AddReplayScreenState();
}

class _AddReplayScreenState extends State<AddReplayScreen> {
  TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.close,
            color: AppColors.grey,
            size: 33,
          ),
        ),
        title: const Text(
          'Replay',
          style: TextStyle(
            color: AppColors.grey,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (controller.value.text.trim().isNotEmpty) {
                PostCubit.get(context).addNewReplay(
                  replayModel: ReplayModel(
                    id: uuid.v1(),
                    comment: controller.text.trim(),
                    userId: currentUserId,
                    userName: currentUserName,
                    userImage: "",
                    time: DateTime.now(),
                  ),
                  id: widget.id,
                );
                Navigator.pop(context);
              }
            },
            child: const Text(
              'Post',
              style: TextStyle(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    widget.userName,
                    style: const TextStyle(
                      color: AppColors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    timeago.format(widget.time, locale: 'en_short'),
                    style: const TextStyle(
                      color: AppColors.grey,
                      fontSize: 14,
                      //fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Text(
                widget.comment,
                style: const TextStyle(color: AppColors.white2, fontSize: 16),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Divider(
                  color: AppColors.grey,
                  thickness: 0.5,
                ),
              ),
              TextField(
                controller: controller,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Your Replay',
                  hintStyle: TextStyle(
                    color: AppColors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
                maxLines: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
