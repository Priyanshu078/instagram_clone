part of 'posts_bloc.dart';

abstract class PostsEvent extends Equatable {
  const PostsEvent();

  @override
  List<Object> get props => [];
}

class ChooseImage extends PostsEvent {
  final bool fromCamera;
  const ChooseImage({required this.fromCamera});
  @override
  List<Object> get props => [fromCamera];
}

class CancelEvent extends PostsEvent {}

class PostImage extends PostsEvent {
  final String caption;
  final String userProfilePhotoUrl;
  const PostImage(this.caption, this.userProfilePhotoUrl);

  @override
  List<Object> get props => [caption, userProfilePhotoUrl];
}
