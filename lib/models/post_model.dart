

class PostModel {
  final String id;
  final String title;
  final String url;
  final String userName;
  final String userImage;
  final String userId;

  PostModel({
    required this.id,
    required this.title,
    required this.url,
    required this.userName,
    required this.userImage,
    required this.userId,
  });

  factory PostModel.fromJson(Map<String, dynamic> map) => PostModel(
    id: map['id'],
    title: map['title'],
    url: map['url'],
    userName: map['user-name'],
    userImage: map['user-image-url'],
    userId: map['user-id'],
  );
}