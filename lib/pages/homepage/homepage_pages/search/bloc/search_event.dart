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
