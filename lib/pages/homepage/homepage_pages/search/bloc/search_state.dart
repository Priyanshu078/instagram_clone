part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState(this.posts, this.usersList);
  final List<Post> posts;
  final List<UserData> usersList;

  @override
  List<Object> get props => [posts, usersList];
}

class SearchInitial extends SearchState {
  const SearchInitial(super.posts, super.usersList);

  @override
  List<Object> get props => [posts, usersList];
}

class PostsFetched extends SearchState {
  const PostsFetched(super.posts, super.usersList);

  @override
  List<Object> get props => [posts, usersList];
}

class UsersSearched extends SearchState {
  const UsersSearched(super.posts, super.usersList);

  @override
  List<Object> get props => [posts, usersList];
}
