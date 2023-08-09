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
  final bool inFeed;
  const PostLikeEvent(this.postId, this.index, this.userId, this.inFeed);

  @override
  List<Object> get props => [postId, index, userId, inFeed];
}

class AddFeedComment extends FeedEvent {
  final List<Comments> comments;
  final int postIndex;
  final String comment;
  final bool inFeed;
  const AddFeedComment(
      this.comments, this.postIndex, this.comment, this.inFeed);

  @override
  List<Object> get props => [comments, postIndex, comment, inFeed];
}

class DeleteFeedComment extends FeedEvent {
  final int postIndex;
  final int commentIndex;
  final bool inFeed;
  const DeleteFeedComment(this.postIndex, this.commentIndex, this.inFeed);
  @override
  List<Object> get props => [postIndex, commentIndex, inFeed];
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

class GetMyStory extends FeedEvent {}

class DeleteMyStory extends FeedEvent {}

class FollowFeedEvent extends FeedEvent {
  final bool fromFeed;
  final int? index;
  const FollowFeedEvent({required this.fromFeed, this.index});
  @override
  List<Object> get props => [fromFeed];
}

class UnFollowFeedEvent extends FeedEvent {
  final bool fromFeed;
  final int? index;
  const UnFollowFeedEvent({required this.fromFeed, this.index});
  @override
  List<Object> get props => [fromFeed];
}

class StoryViewEvent extends FeedEvent {
  final bool viewMyStory;
  final int? index;
  const StoryViewEvent({required this.viewMyStory, this.index});
  @override
  List<Object> get props => [viewMyStory];
}

class ShareFileEvent extends FeedEvent {
  final String imageUrl;
  final String caption;
  const ShareFileEvent({required this.caption, required this.imageUrl});

  @override
  List<Object> get props => [imageUrl];
}
