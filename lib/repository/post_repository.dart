import 'package:reddit_post/dummy_data.dart';
import 'package:reddit_post/models/comment_model.dart';
import 'package:reddit_post/models/vote_model.dart';

import '../models/post_model.dart';
import '../models/replay_model.dart';

class PostRepository {
  List<PostModel> getPosts() {
    return List<PostModel>.from(
        dataJson['posts'].map((x) => PostModel.fromJson(x)));
  }

  VoteModel getVote({required String id}) {
    return VoteModel.fromJson(dataJson['votes'][id]);
  }

  List<CommentModel> getComments({required String id}) {
    return dataJson['comments'][id] != null
        ? List<CommentModel>.from(
            dataJson['comments'][id].map((x) => CommentModel.fromJson(x)))
        : [];
  }

  List<Votes> get getAllVotes {
    List<Votes> votes = dataJson['votes'].entries.map<Votes>((item) {
      return Votes(
        id: item.key,
        voteModel: VoteModel.fromJson(item.value),
      );
    }).toList();
    return votes;
  }

  List<Comments> getAllComments() {
    List<Comments> comments = dataJson['comments']
        .entries
        .map<Comments>(
          (item) => Comments(
            id: item.key,
            commentModel: List<CommentModel>.from(
                item.value.map((x) => CommentModel.fromJson(x))),
          ),
        )
        .toList();
    return comments;
  }

  void addNewComment({
    required CommentModel commentModel,
    required String id,
  }) {
    List<CommentModel> comments = List<CommentModel>.from(
        dataJson['comments'][id].map((x) => CommentModel.fromJson(x)));
    comments.add(commentModel);
   // dataJson['comments'][id] = comments.forEach((element) {return CommentModel.toMap()});
  }

  List<Replies> getAllReplies() {
    List<Replies> replies = dataJson['replies']
        .entries
        .map<Replies>((item) => Replies(
              id: item.key,
              replies: List<ReplayModel>.from(
                  item.value.map((x) => ReplayModel.fromJson(x))),
            ))
        .toList();
    return replies;
  }
}
