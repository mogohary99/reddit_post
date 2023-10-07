import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constants/assets_manager.dart';
import '../../../core/constants/colors_manager.dart';


class BestCommentsButton extends StatelessWidget {
  const BestCommentsButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: (){
        },
        splashColor: Colors.black87,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10,),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(AppIcons.rocketIcon,width: 22,),
              const SizedBox(width: 5),
              const Text(
                'BEST COMMENTS',
                style: TextStyle(
                    color: AppColors.grey,
                    fontWeight: FontWeight.w700,
                    fontSize: 12
                ),
              ),
              const SizedBox(width: 5),
              const Icon(
                Icons.keyboard_arrow_down,
                color: AppColors.grey,
                size: 16,
              )
            ],
          ),
        ),
      ),
    );
  }
}
