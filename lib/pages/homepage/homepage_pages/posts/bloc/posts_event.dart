part of 'posts_bloc.dart';

abstract class PostsEvent extends Equatable {
  const PostsEvent();

  @override
  List<Object> get props => [];
}

class ChooseImage extends PostsEvent {}

class CancelEvent extends PostsEvent {}

class PostImage extends PostsEvent {
  final String caption;
  final String userProfilePhotoUrl;
  const PostImage(this.caption, this.userProfilePhotoUrl);

  @override
  List<Object> get props => [caption, userProfilePhotoUrl];
}
