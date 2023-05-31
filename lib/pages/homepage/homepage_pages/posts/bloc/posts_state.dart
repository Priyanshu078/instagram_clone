part of 'posts_bloc.dart';

abstract class PostsState extends Equatable {
  const PostsState();

  @override
  List<Object> get props => [];
}

class PostsInitial extends PostsState {}

class PostReady extends PostsState {
  final File image;
  const PostReady(this.image);

  @override
  List<Object> get props => [image];
}

class PostDone extends PostsState {}
