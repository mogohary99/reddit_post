import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit_post/controller/post_cubit/post_state.dart';
import 'package:reddit_post/core/enums/enums.dart';
import 'package:reddit_post/repository/post_repository.dart';

import '../../models/comment_model.dart';
import '../../models/post_model.dart';
import '../../models/replay_model.dart';
import '../../models/vote_model.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit() : super(const PostInitial());

  final PostRepository _postRepository = PostRepository();

  static PostCubit get(context) => BlocProvider.of(context);

  List<PostModel> posts = [];
  List<Comments> comments = [];
  List<Replies> replies = [];
  List<Votes> votes = [];

  void getPosts() {
    emit(const GetPostsLoadingState());
    posts = _postRepository.getPosts();
    emit(const GetPostsSuccessState());
  }

  void getComments() {
    emit(const GetCommentsLoadingState());
    comments = _postRepository.getAllComments();
    emit(const GetCommentsSuccessState());
  }

  void getReplies() {
    emit(const GetRepliesLoadingState());
    replies = _postRepository.getAllReplies();
    emit(const GetRepliesSuccessState());
  }

  void getVotes() {
    emit(const GetRepliesLoadingState());
    votes = _postRepository.getAllVotes;
    emit(const GetRepliesSuccessState());
  }

  List<ReplayModel> getRepliesOfId({required String id}) {
    //emit(GetRepliesOfIdLoadingState());
    List<ReplayModel> relay = [];
    replies.forEach((element) {
      if (element.id == id) {
        relay = element.replies;
      }
    });
    return relay;
  }

  int getNumOfVotes({required String id}) {
    int num = 0;
    votes.forEach((element) {
      if (element.id == id) {
        //num = element.voteModel.upVotes.length -element.voteModel.downVotes.length;
        num = element.voteModel.votes;
        return;
      }
    });
    //votes.sort((a,b)=>a.voteModel.votes.compareTo(b.voteModel.votes));
    return num;
  }

  void addNewComment({
    required CommentModel commentModel,
    required String id,
  }) {
    emit(const GetCommentsLoadingState());
    comments.forEach((element) {
      if (element.id == id) {
        element.commentModel.add(commentModel);
        return;
      }
    });
    emit(const GetCommentsSuccessState());
  }

  void addNewReplay({
    required ReplayModel replayModel,
    required String id,
  }) {
    emit(const GetCommentsLoadingState());
    bool added = false;
    replies.forEach((element) {
      if (element.id == id) {
        element.replies.add(replayModel);
        added = true;
        return;
      }
    });
    if (!added) {
      replies.add(Replies(id: id, replies: [replayModel]));
    }
    emit(const GetCommentsSuccessState());
  }

  void deleteComment({required String id}) {
    emit(const GetCommentsLoadingState());
    for (int i = 0; i < comments[0].commentModel.length; i++) {
      if (comments[0].commentModel[i].id == id) {
        //print(comments[i]);
        comments[0].commentModel.removeAt(i);

        return;
      }
    }
    emit(const GetCommentsSuccessState());
  }

  void deleteReply({required String id, required String baseId}) {
    emit(const GetCommentsLoadingState());
    for (int j=0;j<replies.length;j++) {
      if (replies[j].id == baseId) {
        for (int i = 0; i < replies[j].replies.length; i++) {
          if (replies[j].replies[i].id == id) {
            replies[j].replies.removeAt(i);
            return;
          }
        }
      }
    }

    emit(const GetCommentsSuccessState());
  }

}
