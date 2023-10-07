class Comments{
  final String id;
  final List<CommentModel> commentModel;

  Comments({required this.id, required this.commentModel});
}


class CommentModel extends BaseComment {
  CommentModel({
    required super.id,
    required super.comment,
    required super.userId,
    required super.userName,
    required super.userImage,
    required super.time,
  });

  factory CommentModel.fromJson(Map<String, dynamic> map) => CommentModel(
        id: map['id'],
        comment: map['comment'],
        userId: map['user-id'],
        userName: map['user-name'],
        userImage: map['user-image-url'],
        time: DateTime.fromMillisecondsSinceEpoch(int.parse(map['time'])),
      );

  Map<String,dynamic> toMap(){
    return{
      'id':id,
      'comment':comment,
      'user-id': userId,
      'user-name':userName,
      'user-image-url':userImage,
      'time':time.millisecondsSinceEpoch.toString()
    };
  }
}

class BaseComment {
  final String id;
  final String comment;
  final String userId;
  final String userName;
  final String userImage;
  final DateTime time;

  BaseComment({
    required this.id,
    required this.comment,
    required this.userId,
    required this.userName,
    required this.userImage,
    required this.time,
  });
}
