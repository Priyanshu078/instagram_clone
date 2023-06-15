part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class GetUserDetails extends ProfileEvent {}

class EditUserDetails extends ProfileEvent {
  final UserData userData;
  const EditUserDetails(this.userData);

  @override
  List<Object> get props => [userData];
}

class ChangeProfilePhotoEvent extends ProfileEvent {
  final UserData userData;
  const ChangeProfilePhotoEvent(this.userData);

  @override
  List<Object> get props => [userData];
}

class LogoutEvent extends ProfileEvent {}

class ProfilePrivateEvent extends ProfileEvent {
  final UserData userData;
  const ProfilePrivateEvent(this.userData);

  @override
  List<Object> get props => [userData];
}

class TabChangeEvent extends ProfileEvent {
  final int tabIndex;
  const TabChangeEvent(this.tabIndex);

  @override
  List<Object> get props => [tabIndex];
}

class PostsIndexChangeEvent extends ProfileEvent {
  final int postIndex;
  const PostsIndexChangeEvent(this.postIndex);

  @override
  List<Object> get props => [postIndex];
}

class LikePostEvent extends ProfileEvent {
  final int index;
  const LikePostEvent(this.index);

  @override
  List<Object> get props => [index];
}
