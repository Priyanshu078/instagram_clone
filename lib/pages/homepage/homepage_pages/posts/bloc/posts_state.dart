part of 'posts_bloc.dart';

abstract class PostsState extends Equatable {
  final String imagePath;
  const PostsState(this.imagePath);

  @override
  List<Object> get props => [imagePath];
}

class PostsInitial extends PostsState {
  const PostsInitial(super.imagePath);
  @override
  List<Object> get props => [imagePath];
}

class PostReady extends PostsState {
  const PostReady(super.imagePath);

  @override
  List<Object> get props => [imagePath];
}

class PostDone extends PostsState {
  const PostDone(super.imagePath);

  @override
  List<Object> get props => [imagePath];
}

class PostingImageState extends PostsState {
  const PostingImageState(super.imagePath);

  @override
  List<Object> get props => [imagePath];
}
