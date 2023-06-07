part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState(this.posts, this.usersList, this.userData);
  final List<Post> posts;
  final List<UserData> usersList;
  final UserData userData;

  @override
  List<Object> get props => [posts, usersList, userData];
}

class SearchInitial extends SearchState {
  const SearchInitial(super.posts, super.usersList, super.userData);

  @override
  List<Object> get props => [posts, usersList, userData];
}

class PostsFetched extends SearchState {
  const PostsFetched(super.posts, super.usersList, super.userData);

  @override
  List<Object> get props => [posts, usersList, userData];
}

class UsersSearched extends SearchState {
  const UsersSearched(super.posts, super.usersList, super.userData);

  @override
  List<Object> get props => [posts, usersList, userData];
}

class UserProfileState extends SearchState {
  const UserProfileState(super.posts, super.usersList, super.userData);

  @override
  List<Object> get props => [posts, usersList, userData];
}
