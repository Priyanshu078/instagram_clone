part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState(this.posts, this.usersList, this.userData, this.tabIndex,
      this.postsIndex, this.usersPosts, this.myData);
  final List<Post> posts;
  final List<UserData> usersList;
  final UserData userData;
  final UserData myData;
  final int postsIndex;
  final int tabIndex;
  final bool usersPosts;

  @override
  List<Object> get props =>
      [posts, usersList, userData, tabIndex, postsIndex, usersPosts, myData];
}

class SearchInitial extends SearchState {
  const SearchInitial(super.posts, super.usersList, super.userData,
      super.tabIndex, super.postsIndex, super.usersPosts, super.myData);

  @override
  List<Object> get props =>
      [posts, usersList, userData, tabIndex, postsIndex, usersPosts, myData];
}

class PostsFetched extends SearchState {
  const PostsFetched(super.posts, super.usersList, super.userData,
      super.tabIndex, super.postsIndex, super.usersPosts, super.myData);

  @override
  List<Object> get props =>
      [posts, usersList, userData, tabIndex, postsIndex, usersPosts, myData];
}

class UsersSearched extends SearchState {
  const UsersSearched(super.posts, super.usersList, super.userData,
      super.tabIndex, super.postsIndex, super.usersPosts, super.myData);

  @override
  List<Object> get props =>
      [posts, usersList, userData, tabIndex, postsIndex, usersPosts, myData];
}

class UserProfileState extends SearchState {
  const UserProfileState(super.posts, super.usersList, super.userData,
      super.tabIndex, super.postsIndex, super.usersPosts, super.myData);

  @override
  List<Object> get props =>
      [posts, usersList, userData, tabIndex, postsIndex, usersPosts, myData];
}

class TabChangeState extends SearchState {
  const TabChangeState(super.posts, super.usersList, super.userData,
      super.tabIndex, super.postsIndex, super.usersPosts, super.myData);

  @override
  List<Object> get props =>
      [posts, usersList, userData, tabIndex, postsIndex, usersPosts, myData];
}

class PostIndexChangedState extends SearchState {
  const PostIndexChangedState(super.posts, super.usersList, super.userData,
      super.tabIndex, super.postsIndex, super.usersPosts, super.myData);

  @override
  List<Object> get props =>
      [posts, usersList, userData, tabIndex, postsIndex, usersPosts, myData];
}

class LikePostState extends SearchState {
  const LikePostState(super.posts, super.usersList, super.userData,
      super.tabIndex, super.postsIndex, super.usersPosts, super.myData);

  @override
  List<Object> get props =>
      [posts, usersList, userData, tabIndex, postsIndex, usersPosts, myData];
}

class AddedCommentSearchState extends SearchState {
  const AddedCommentSearchState(super.posts, super.usersList, super.userData,
      super.tabIndex, super.postsIndex, super.usersPosts, super.myData);

  @override
  List<Object> get props =>
      [posts, usersList, userData, tabIndex, postsIndex, usersPosts, myData];
}

class DeletedCommentSearchState extends SearchState {
  const DeletedCommentSearchState(super.posts, super.usersList, super.userData,
      super.tabIndex, super.postsIndex, super.usersPosts, super.myData);

  @override
  List<Object> get props =>
      [posts, usersList, userData, tabIndex, postsIndex, usersPosts, myData];
}

class BookmarkedSearchState extends SearchState {
  const BookmarkedSearchState(super.posts, super.usersList, super.userData,
      super.tabIndex, super.postsIndex, super.usersPosts, super.myData);

  @override
  List<Object> get props =>
      [posts, usersList, userData, tabIndex, postsIndex, usersPosts, myData];
}
