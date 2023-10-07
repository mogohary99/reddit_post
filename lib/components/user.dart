import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constants/assets_manager.dart';
import '../../../core/constants/colors_manager.dart';

class User extends StatelessWidget {
  final String name;
  final String image;
  const User({
    super.key, required this.name,  this.image =AppIcons.redditIcon2,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          image,
          width: 28,
          height: 28,
        ),
        const SizedBox(width: 8),
        Text(
          name,
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}
