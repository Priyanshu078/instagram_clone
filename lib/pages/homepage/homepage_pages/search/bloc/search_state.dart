part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState(this.posts);
  final List<Post> posts;

  @override
  List<Object> get props => [posts];
}

class SearchInitial extends SearchState {
  const SearchInitial(super.posts);

  @override
  List<Object> get props => [posts];
}

class PostsFetched extends SearchState {
  const PostsFetched(super.posts);

  @override
  List<Object> get props => [posts];
}
