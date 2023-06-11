part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class GetPosts extends SearchEvent {}

class SearchUsers extends SearchEvent {
  final String text;
  const SearchUsers(this.text);
  @override
  List<Object> get props => [text];
}

class UserProfileEvent extends SearchEvent {
  final UserData userData;
  const UserProfileEvent(this.userData);
  @override
  List<Object> get props => [userData];
}

class UserProfileBackEvent extends SearchEvent {}

class TabChangeEvent extends SearchEvent {
  final int tabIndex;
  const TabChangeEvent(this.tabIndex);
  @override
  List<Object> get props => [tabIndex];
}

class PostsIndexChangeEvent extends SearchEvent {
  final int postIndex;
  final bool usersPosts;
  const PostsIndexChangeEvent(this.postIndex, this.usersPosts);

  @override
  List<Object> get props => [postIndex, usersPosts];
}
