import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit_post/controller/post_cubit/post_cubit.dart';
import 'package:reddit_post/controller/post_cubit/post_state.dart';
import 'package:reddit_post/models/post_model.dart';
import 'package:reddit_post/views/post_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostCubit,PostState>(
      builder: (context,state){
        if(state is GetPostsLoadingState){
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        PostModel post = PostCubit.get(context).posts[0];
        return PostScreen(post: post,);
      },
    );
  }
}
