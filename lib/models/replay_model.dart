import 'package:reddit_post/models/comment_model.dart';

class Replies{
  final String id;
  final List<ReplayModel> replies;

  Replies({required this.id, required this.replies});
}


class ReplayModel extends BaseComment {
  ReplayModel({
    required super.id,
    required super.comment,
    required super.userId,
    required super.userName,
    required super.userImage,
    required super.time,
  });

  factory ReplayModel.fromJson(Map<String, dynamic> map) => ReplayModel(
        id: map['id'],
        comment: map['comment'],
        userId: map['user-id'],
        userName: map['user-name'],
        userImage: map['user-image-url'],
        time:  DateTime.fromMillisecondsSinceEpoch(int.parse(map['time'])),
      );
}
