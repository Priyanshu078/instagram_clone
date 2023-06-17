part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState(this.posts, this.usersList, this.userData, this.tabIndex,
      this.postsIndex, this.usersPosts);
  final List<Post> posts;
  final List<UserData> usersList;
  final UserData userData;
  final int postsIndex;
  final int tabIndex;
  final bool usersPosts;

  @override
  List<Object> get props =>
      [posts, usersList, userData, tabIndex, postsIndex, usersPosts];
}

class SearchInitial extends SearchState {
  const SearchInitial(super.posts, super.usersList, super.userData,
      super.tabIndex, super.postsIndex, super.usersPosts);

  @override
  List<Object> get props =>
      [posts, usersList, userData, tabIndex, postsIndex, usersPosts];
}

class PostsFetched extends SearchState {
  const PostsFetched(super.posts, super.usersList, super.userData,
      super.tabIndex, super.postsIndex, super.usersPosts);

  @override
  List<Object> get props =>
      [posts, usersList, userData, tabIndex, postsIndex, usersPosts];
}

class UsersSearched extends SearchState {
  const UsersSearched(super.posts, super.usersList, super.userData,
      super.tabIndex, super.postsIndex, super.usersPosts);

  @override
  List<Object> get props =>
      [posts, usersList, userData, tabIndex, postsIndex, usersPosts];
}

class UserProfileState extends SearchState {
  const UserProfileState(super.posts, super.usersList, super.userData,
      super.tabIndex, super.postsIndex, super.usersPosts);

  @override
  List<Object> get props =>
      [posts, usersList, userData, tabIndex, postsIndex, usersPosts];
}

class TabChangeState extends SearchState {
  const TabChangeState(super.posts, super.usersList, super.userData,
      super.tabIndex, super.postsIndex, super.usersPosts);

  @override
  List<Object> get props =>
      [posts, usersList, userData, tabIndex, postsIndex, usersPosts];
}

class PostIndexChangedState extends SearchState {
  const PostIndexChangedState(super.posts, super.usersList, super.userData,
      super.tabIndex, super.postsIndex, super.usersPosts);

  @override
  List<Object> get props =>
      [posts, usersList, userData, tabIndex, postsIndex, usersPosts];
}

class LikePostState extends SearchState {
  const LikePostState(super.posts, super.usersList, super.userData,
      super.tabIndex, super.postsIndex, super.usersPosts);

  @override
  List<Object> get props =>
      [posts, usersList, userData, tabIndex, postsIndex, usersPosts];
}
