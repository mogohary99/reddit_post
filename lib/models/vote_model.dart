class Votes {
  final String id;
  final VoteModel voteModel;

  Votes({required this.id, required this.voteModel});
}

class VoteModel {
  final List<String> upVotes;
  final List<String> downVotes;
  int votes = 0;

  VoteModel({
    required this.upVotes,
    required this.downVotes,
  }) {
    votes = upVotes.length - downVotes.length;
  }

  factory VoteModel.fromJson(Map<String, dynamic> map) => VoteModel(
        upVotes: List<String>.from(map['up-votes']),
        downVotes: List<String>.from(map['down-votes']),
      );
}
