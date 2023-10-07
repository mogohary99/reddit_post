import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:reddit_post/controller/post_cubit/post_cubit.dart';
import 'package:reddit_post/models/post_model.dart';

import '../../../core/constants/assets_manager.dart';
import '../../../core/constants/colors_manager.dart';
import '../views/comments_screen.dart';

class VoteCommentShareButtons extends StatefulWidget {
  const VoteCommentShareButtons({
    super.key,
    required this.controller, required this.postModel,
  });

  final PostModel postModel;
  final CachedVideoPlayerController controller;

  @override
  State<VoteCommentShareButtons> createState() => _VoteCommentShareButtonsState();
}

class _VoteCommentShareButtonsState extends State<VoteCommentShareButtons> {
  bool up=false;
  bool down =false;
  int numOfVotes =10;

  @override
  Widget build(BuildContext context) {
   // int numOfVotes=PostCubit.get(context).getNumOfVotes(id: widget.postModel.id);
    return Column(
      children: [
        InkWell(
          onTap: (){
            if(up){
              up=false;
              numOfVotes--;
              setState(() {
              });
            }
            else if(up ==false && down==false){
              up=true;
              numOfVotes++;
              setState(() {
              });
            }
            else if(up ==false && down==true){
              up=true;
              down=false;
              numOfVotes += 2;
              setState(() {

              });
            }
          },
          child: SvgPicture.asset(
            up? AppIcons.topIcon:AppIcons.topOutIcon,
            width: 25,
            color: up? Colors.red:AppColors.white,
          ),
        ),
        const SizedBox(height: 12),
         Text(
          numOfVotes.toString(),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 12),
        InkWell(
          onTap: (){
            if(down){
              down=false;
              numOfVotes++;
              setState(() {
              });
            }
            else if(up ==false && down==false){
              down=true;
              numOfVotes--;
              setState(() {
              });
            }
            else if(up ==true && down==false){
              up=false;
              down=true;
              numOfVotes -= 2;
              setState(() {

              });
            }
          },
          child: SvgPicture.asset(
            down? AppIcons.downIcon: AppIcons.downOutIcon,
            width: 25,
            color: down? Colors.green:AppColors.white,
          ),
        ),
        const SizedBox(height: 30),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>
                    CommentsScreen(controller: widget.controller,postModel: widget.postModel),
              ),
            );
          },
          child: SvgPicture.asset(
            AppIcons.commentIcon,
            width: 25,
            color: AppColors.white,
          ),
        ),
        const SizedBox(height: 5),
        const Text(
          '61',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 30),
        SvgPicture.asset(
          AppIcons.shareIcon,
          width: 25,
          color: AppColors.white,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
