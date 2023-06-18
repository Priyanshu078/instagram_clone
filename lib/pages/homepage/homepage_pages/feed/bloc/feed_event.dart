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

class AddComment extends FeedEvent {
  final List<Comments> comments;
  final int postIndex;
  const AddComment(this.comments, this.postIndex);

  @override
  List<Object> get props => [comments, postIndex];
}
