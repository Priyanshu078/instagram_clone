part of 'feed_bloc.dart';

abstract class FeedEvent extends Equatable {
  const FeedEvent();

  @override
  List<Object> get props => [];
}

class GetFeed extends FeedEvent {
  final bool atStart;
  const GetFeed(this.atStart);

  @override
  List<Object> get props => [atStart];
}

class PostLikeEvent extends FeedEvent {
  final String postId;
  final int index;
  final String userId;
  const PostLikeEvent(this.postId, this.index, this.userId);

  @override
  List<Object> get props => [postId, index, userId];
}

class AddFeedComment extends FeedEvent {
  final List<Comments> comments;
  final int postIndex;
  final String comment;
  const AddFeedComment(this.comments, this.postIndex, this.comment);

  @override
  List<Object> get props => [comments, postIndex, comment];
}

class DeleteFeedComment extends FeedEvent {
  final int postIndex;
  final int commentIndex;
  const DeleteFeedComment(this.postIndex, this.commentIndex);
  @override
  List<Object> get props => [postIndex, commentIndex];
}

class BookmarkFeed extends FeedEvent {
  final int postIndex;
  final bool inFeed;
  const BookmarkFeed(this.postIndex, this.inFeed);
  @override
  List<Object> get props => [postIndex, inFeed];
}

class FetchUserData extends FeedEvent {
  final String userId;
  const FetchUserData(this.userId);
  @override
  List<Object> get props => [userId];
}

class TabChangeFeedEvent extends FeedEvent {
  final int tabIndex;
  const TabChangeFeedEvent(this.tabIndex);
  @override
  List<Object> get props => [tabIndex];
}

class FeedPostsIndexChangeEvent extends FeedEvent {
  final int postIndex;
  const FeedPostsIndexChangeEvent(this.postIndex);
  @override
  List<Object> get props => [postIndex];
}
