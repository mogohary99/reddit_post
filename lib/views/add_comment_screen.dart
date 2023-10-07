import 'package:flutter/material.dart';
import 'package:reddit_post/controller/post_cubit/post_cubit.dart';
import 'package:reddit_post/core/constants/colors_manager.dart';
import 'package:reddit_post/main.dart';
import 'package:reddit_post/models/post_model.dart';

import '../models/comment_model.dart';

class AddCommentScreen extends StatefulWidget {
  final PostModel postModel;

  const AddCommentScreen({super.key, required this.postModel});

  @override
  State<AddCommentScreen> createState() => _AddCommentScreenState();
}

class _AddCommentScreenState extends State<AddCommentScreen> {
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
          'Add comment',
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
                PostCubit.get(context).addNewComment(
                  commentModel: CommentModel(
                    id: uuid.v1(),
                    comment: controller.text.trim(),
                    time: DateTime.now(),
                    userId: currentUserId,
                    userImage: "",
                    userName: currentUserName,
                  ),
                  id: widget.postModel.id,
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
            children: [
              Text(
                widget.postModel.title,
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
                  hintText: 'Your comment',
                  hintStyle: TextStyle(
                    color: AppColors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: TextStyle(
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
