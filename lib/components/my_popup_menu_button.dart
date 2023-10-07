import 'package:flutter/material.dart';
import 'package:reddit_post/controller/post_cubit/post_cubit.dart';
import 'package:reddit_post/main.dart';

import '../core/constants/colors_manager.dart';

class MyBopupMenuButton extends StatelessWidget {
  final String userId;
  final String id;
  final String? baseId;

  const MyBopupMenuButton({
    super.key,
    required this.userId, required this.id, this.baseId,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      padding: EdgeInsets.zero,
      icon: const Icon(
        Icons.more_vert_outlined,
        color: Colors.grey,
        size: 18,
      ),
      color: Colors.grey.shade900,
      position: PopupMenuPosition.over,
      constraints: BoxConstraints(maxWidth: 235),
      itemBuilder: (BuildContext context) {
        return <PopupMenuEntry>[
          buildPopupMenuItem(icon: Icons.replay, title: 'Share', onTap: () {}),
          buildPopupMenuItem(
              icon: Icons.save_rounded, title: 'Save', onTap: () {}),
          buildPopupMenuItem(
              icon: Icons.notifications_none,
              title: 'Get reply notifications',
              onTap: () {}),
          buildPopupMenuItem(
              icon: Icons.copy, title: 'Copy text', onTap: () {}),
          buildPopupMenuItem(
              icon: Icons.add, title: 'Collapse thread', onTap: () {}),
          if (userId != currentUserId) ...[
            buildPopupMenuItem(
                icon: Icons.block_outlined,
                title: 'Block account',
                onTap: () {}),
            buildPopupMenuItem(
                icon: Icons.report_problem, title: 'report', onTap: () {}),
          ],
          if (userId == currentUserId) ...[
            buildPopupMenuItem(icon: Icons.edit, title: 'Edit', onTap: () {}),
            buildPopupMenuItem(
              icon: Icons.delete_outline_rounded,
              title: 'Delete',
              onTap: () {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(
                          "Are yo sure?",
                          style: TextStyle(
                            color: Colors.white
                          ),
                        ),
                        backgroundColor: Colors.grey.shade900,
                        content: Text(
                          "You canot restore comments that have been deleted",
                          style: TextStyle(
                              color: Colors.white
                          ),
                        ),
                        actions: [
                          SizedBox(
                            width:double.infinity,
                            child: Row(
                              children: [
                                Expanded(
                                  child: MaterialButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    color: Colors.grey.shade900,
                                    child: Text(
                                      'Cancel',
                                      style: TextStyle(
                                          color: Colors.white60,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: MaterialButton(
                                    onPressed: () {
                                      if(baseId != null){
                                        PostCubit.get(context).deleteReply(id: id, baseId: baseId!);
                                      }else{
                                        PostCubit.get(context).deleteComment(id: id);
                                      }

                                      Navigator.pop(context);
                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    color: Colors.red,
                                    child: Text(
                                      'Delete',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                        ],
                      );
                    },
                  );
                });
              },
            ),
          ]
        ];
      },
      onSelected: (value) {
        // Handle the selected option
        print('Selected: $value');
      },
    );
  }

  PopupMenuItem<dynamic> buildPopupMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return PopupMenuItem(
      value: title,
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          )
        ],
      ),
    );
  }
}
