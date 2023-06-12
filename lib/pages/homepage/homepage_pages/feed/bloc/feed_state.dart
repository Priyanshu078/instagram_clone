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

class PostsFetched extends FeedState {
  const PostsFetched(super.posts);

  @override
  List<Object> get props => [posts];
}
