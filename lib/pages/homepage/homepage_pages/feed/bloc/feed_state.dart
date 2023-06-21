part of 'feed_bloc.dart';

abstract class FeedState extends Equatable {
  const FeedState(this.posts, this.userData);
  final List<Post> posts;
  final UserData userData;
  @override
  List<Object> get props => [posts, userData];
}

class FeedInitial extends FeedState {
  const FeedInitial(super.posts, super.userdata);

  @override
  List<Object> get props => [posts, userData];
}

class FeedFetched extends FeedState {
  const FeedFetched(super.posts, super.userdata);

  @override
  List<Object> get props => [posts, userData];
}

class PostLikedState extends FeedState {
  const PostLikedState(super.posts, super.userdata);

  @override
  List<Object> get props => [posts, userData];
}

class CommentAddedState extends FeedState {
  const CommentAddedState(super.posts, super.userdata);
  @override
  List<Object> get props => [posts, userData];
}

class CommentDeletedState extends FeedState {
  const CommentDeletedState(super.posts, super.userdata);
  @override
  List<Object> get props => [posts, userData];
}
