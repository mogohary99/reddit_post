import 'package:flutter/material.dart';
import 'package:reddit_post/components/user.dart';

import '../../../core/constants/colors_manager.dart';


class PostTitleCardAtCommentsScreen extends StatelessWidget {
  const PostTitleCardAtCommentsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.blackLight,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: const Column(
        children: [
          User(name: 'Xury46'),
          SizedBox(height: 10),
          Text(
            'After a year of collecting parts for this build, i present my finished Heavy-9',
            style: TextStyle(
              color: Color(0xffD9DDE0),
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
