import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit_post/components/post_title_card_at_comment_screen.dart';
import 'package:reddit_post/core/constants/colors_manager.dart';

import '../controller/post_cubit/post_cubit.dart';
import '../controller/post_cubit/post_state.dart';
import '../models/comment_model.dart';
import 'best_comments_button.dart';
import 'comment_card.dart';

class BottomSheetBody extends StatelessWidget {
  const BottomSheetBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PostTitleCardAtCommentsScreen(),
        const BestCommentsButton(),
        BlocBuilder<PostCubit, PostState>(
          builder: (context, state) {
            Comments comment = PostCubit.get(context).comments[0];
            return ListView.builder(
              itemCount: comment.commentModel.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return CommentCard(
                  commentModel: comment.commentModel[index],
                );
              },
            );
          },
        ),
        const SizedBox(height: 70)
      ],
    );
  }
}
