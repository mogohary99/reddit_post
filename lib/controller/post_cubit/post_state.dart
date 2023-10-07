import 'package:equatable/equatable.dart';

abstract class PostState extends Equatable {
  const PostState();
}

class PostInitial extends PostState {
  const PostInitial();
  @override
  List<Object> get props => [];
}

class GetPostsLoadingState extends PostState{
  const GetPostsLoadingState();
  @override
  List<Object?> get props => [];
}

class GetPostsSuccessState extends PostState{
  const GetPostsSuccessState();
  @override
  List<Object?> get props => [];
}

class GetPostsErrorState extends PostState{
  const GetPostsErrorState();
  @override
  List<Object?> get props => [];
}

class GetCommentsLoadingState extends PostState{
  const GetCommentsLoadingState();
  @override
  List<Object?> get props => [];
}

class GetCommentsSuccessState extends PostState{
  const GetCommentsSuccessState();
  @override
  List<Object?> get props => [];
}

class GetCommentsErrorState extends PostState{
  const GetCommentsErrorState();
  @override
  List<Object?> get props => [];
}


class GetRepliesLoadingState extends PostState{
  const GetRepliesLoadingState();
  @override
  List<Object?> get props => [];
}

class GetRepliesSuccessState extends PostState{
  const GetRepliesSuccessState();
  @override
  List<Object?> get props => [];
}

class GetRepliesErrorState extends PostState{
  const GetRepliesErrorState();
  @override
  List<Object?> get props => [];
}

class GetRepliesOfIdLoadingState extends PostState{
  const GetRepliesOfIdLoadingState();
  @override
  List<Object?> get props => [];
}

class GetRepliesOfIdSuccessState extends PostState{
  const GetRepliesOfIdSuccessState();
  @override
  List<Object?> get props => [];
}

class GetRepliesOfIdErrorState extends PostState{
  const GetRepliesOfIdErrorState();
  @override
  List<Object?> get props => [];
}