part of 'feed_bloc.dart';

abstract class FeedState extends Equatable {
  const FeedState(this.posts);
  final List<Post> posts;
  @override
  List<Object> get props => [posts];
}

class FeedInitial extends FeedState {
  const FeedInitial(super.posts);

  @override
  List<Object> get props => [posts];
}

class FeedFetched extends FeedState {
  const FeedFetched(super.posts);

  @override
  List<Object> get props => [posts];
}

class PostLikedState extends FeedState {
  const PostLikedState(super.posts);

  @override
  List<Object> get props => [posts];
}

class CommentAddedState extends FeedState {
  const CommentAddedState(super.posts);
  @override
  List<Object> get props => [posts];
}
