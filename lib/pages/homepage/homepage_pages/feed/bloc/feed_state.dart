part of 'feed_bloc.dart';

abstract class FeedState extends Equatable {
  const FeedState(this.posts, this.myData, this.userData, this.tabIndex,
      this.postsIndex, this.stories, this.myStory);
  final List<Post> posts;
  final UserData myData;
  final UserData userData;
  final int postsIndex;
  final int tabIndex;
  final List<StoryData> stories;
  final StoryData myStory;
  @override
  List<Object> get props =>
      [posts, myData, userData, tabIndex, postsIndex, stories, myStory];
}

class FeedInitial extends FeedState {
  const FeedInitial(super.posts, super.myData, super.userData, super.tabIndex,
      super.postsIndex, super.stories, super.myStory);

  @override
  List<Object> get props =>
      [posts, myData, userData, tabIndex, postsIndex, stories, myStory];
}

class FeedFetched extends FeedState {
  const FeedFetched(super.posts, super.myData, super.userData, super.tabIndex,
      super.postsIndex, super.stories, super.myStory);

  @override
  List<Object> get props =>
      [posts, myData, userData, tabIndex, postsIndex, stories, myStory];
}

class PostLikedState extends FeedState {
  const PostLikedState(super.posts, super.myData, super.userData,
      super.tabIndex, super.postsIndex, super.stories, super.myStory);

  @override
  List<Object> get props =>
      [posts, myData, userData, tabIndex, postsIndex, stories, myStory];
}

class CommentAddedState extends FeedState {
  const CommentAddedState(super.posts, super.myData, super.userData,
      super.tabIndex, super.postsIndex, super.stories, super.myStory);
  @override
  List<Object> get props =>
      [posts, myData, userData, tabIndex, postsIndex, stories, myStory];
}

class CommentDeletedState extends FeedState {
  const CommentDeletedState(super.posts, super.myData, super.userData,
      super.tabIndex, super.postsIndex, super.stories, super.myStory);
  @override
  List<Object> get props =>
      [posts, myData, userData, tabIndex, postsIndex, stories, myStory];
}

class BookmarkedState extends FeedState {
  const BookmarkedState(super.posts, super.myData, super.userData,
      super.tabIndex, super.postsIndex, super.stories, super.myStory);
  @override
  List<Object> get props =>
      [posts, myData, userData, tabIndex, postsIndex, stories, myStory];
}

class UserDataLoadingState extends FeedState {
  const UserDataLoadingState(super.posts, super.myData, super.userData,
      super.tabIndex, super.postsIndex, super.stories, super.myStory);

  @override
  List<Object> get props =>
      [posts, myData, userData, tabIndex, postsIndex, stories, myStory];
}

class UserDataFetchedState extends FeedState {
  const UserDataFetchedState(super.posts, super.myData, super.userData,
      super.tabIndex, super.postsIndex, super.stories, super.myStory);

  @override
  List<Object> get props =>
      [posts, myData, userData, tabIndex, postsIndex, stories, myStory];
}

class TabChangedFeedState extends FeedState {
  const TabChangedFeedState(super.posts, super.myData, super.userData,
      super.tabIndex, super.postsIndex, super.stories, super.myStory);
  @override
  List<Object> get props =>
      [posts, myData, userData, tabIndex, postsIndex, stories, myStory];
}

class PostIndexChangeFeedState extends FeedState {
  const PostIndexChangeFeedState(super.posts, super.myData, super.userData,
      super.tabIndex, super.postsIndex, super.stories, super.myStory);
  @override
  List<Object> get props =>
      [posts, myData, userData, tabIndex, postsIndex, stories, myStory];
}

class MyStoryFetchedState extends FeedState {
  const MyStoryFetchedState(super.posts, super.myData, super.userData,
      super.tabIndex, super.postsIndex, super.stories, super.myStory);
  @override
  List<Object> get props =>
      [posts, myData, userData, tabIndex, postsIndex, stories, myStory];
}

class MyStoryDeletedState extends FeedState {
  const MyStoryDeletedState(super.posts, super.myData, super.userData,
      super.tabIndex, super.postsIndex, super.stories, super.myStory);
  @override
  List<Object> get props =>
      [posts, myData, userData, tabIndex, postsIndex, stories, myStory];
}

class FollowedUserFeedState extends FeedState {
  const FollowedUserFeedState(super.posts, super.myData, super.userData,
      super.tabIndex, super.postsIndex, super.stories, super.myStory);
  @override
  List<Object> get props =>
      [posts, myData, userData, tabIndex, postsIndex, stories, myStory];
}

class FollowingFeedState extends FeedState {
  const FollowingFeedState(super.posts, super.myData, super.userData,
      super.tabIndex, super.postsIndex, super.stories, super.myStory);
  @override
  List<Object> get props =>
      [posts, myData, userData, tabIndex, postsIndex, stories, myStory];
}

class UnFollowingFeedState extends FeedState {
  const UnFollowingFeedState(super.posts, super.myData, super.userData,
      super.tabIndex, super.postsIndex, super.stories, super.myStory);
  @override
  List<Object> get props =>
      [posts, myData, userData, tabIndex, postsIndex, stories, myStory];
}

class UnFollowedUserFeedState extends FeedState {
  const UnFollowedUserFeedState(super.posts, super.myData, super.userData,
      super.tabIndex, super.postsIndex, super.stories, super.myStory);
  @override
  List<Object> get props =>
      [posts, myData, userData, tabIndex, postsIndex, stories, myStory];
}

class StoryViewedState extends FeedState {
  const StoryViewedState(super.posts, super.myData, super.userData,
      super.tabIndex, super.postsIndex, super.stories, super.myStory);

  @override
  List<Object> get props =>
      [posts, myData, userData, tabIndex, postsIndex, stories, myStory];
}
