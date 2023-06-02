part of 'posts_bloc.dart';

abstract class PostsEvent extends Equatable {
  const PostsEvent();

  @override
  List<Object> get props => [];
}

class ChooseImage extends PostsEvent {}

class CancelEvent extends PostsEvent {}

class PostImage extends PostsEvent {
  final File image;
  const PostImage(this.image);

  @override
  List<Object> get props => [image];
}
