part of 'feed_bloc.dart';

abstract class FeedEvent extends Equatable {
  const FeedEvent();

  @override
  List<Object> get props => [];
}

class GetFeed extends FeedEvent {}

class PostLikeEvent extends FeedEvent {
  final String postId;
  final int index;
  final String userId;
  const PostLikeEvent(this.postId, this.index, this.userId);

  @override
  List<Object> get props => [postId, index, userId];
}
