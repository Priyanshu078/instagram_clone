part of 'feed_bloc.dart';

abstract class FeedState extends Equatable {
  const FeedState(this.posts, this.myData, this.userData, this.tabIndex);
  final List<Post> posts;
  final UserData myData;
  final UserData userData;
  final int tabIndex;
  @override
  List<Object> get props => [posts, myData, userData, tabIndex];
}

class FeedInitial extends FeedState {
  const FeedInitial(super.posts, super.myData, super.userData, super.tabIndex);

  @override
  List<Object> get props => [posts, myData, userData, tabIndex];
}

class FeedFetched extends FeedState {
  const FeedFetched(super.posts, super.myData, super.userData, super.tabIndex);

  @override
  List<Object> get props => [posts, myData, userData, tabIndex];
}

class PostLikedState extends FeedState {
  const PostLikedState(
      super.posts, super.myData, super.userData, super.tabIndex);

  @override
  List<Object> get props => [posts, myData, userData, tabIndex];
}

class CommentAddedState extends FeedState {
  const CommentAddedState(
      super.posts, super.myData, super.userData, super.tabIndex);
  @override
  List<Object> get props => [posts, myData, userData, tabIndex];
}

class CommentDeletedState extends FeedState {
  const CommentDeletedState(
      super.posts, super.myData, super.userData, super.tabIndex);
  @override
  List<Object> get props => [posts, myData, userData, tabIndex];
}

class BookmarkedState extends FeedState {
  const BookmarkedState(
      super.posts, super.myData, super.userData, super.tabIndex);
  @override
  List<Object> get props => [posts, myData, userData, tabIndex];
}
