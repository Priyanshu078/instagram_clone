part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState(this.posts, this.usersList, this.userData, this.tabIndex);
  final List<Post> posts;
  final List<UserData> usersList;
  final UserData userData;
  final int tabIndex;

  @override
  List<Object> get props => [posts, usersList, userData, tabIndex];
}

class SearchInitial extends SearchState {
  const SearchInitial(
      super.posts, super.usersList, super.userData, super.tabIndex);

  @override
  List<Object> get props => [posts, usersList, userData, tabIndex];
}

class PostsFetched extends SearchState {
  const PostsFetched(
      super.posts, super.usersList, super.userData, super.tabIndex);

  @override
  List<Object> get props => [posts, usersList, userData, tabIndex];
}

class UsersSearched extends SearchState {
  const UsersSearched(
      super.posts, super.usersList, super.userData, super.tabIndex);

  @override
  List<Object> get props => [posts, usersList, userData, tabIndex];
}

class UserProfileState extends SearchState {
  const UserProfileState(
      super.posts, super.usersList, super.userData, super.tabIndex);

  @override
  List<Object> get props => [posts, usersList, userData, tabIndex];
}

class TabChangeState extends SearchState {
  const TabChangeState(
      super.posts, super.usersList, super.userData, super.tabIndex);

  @override
  List<Object> get props => [posts, usersList, userData, tabIndex];
}
