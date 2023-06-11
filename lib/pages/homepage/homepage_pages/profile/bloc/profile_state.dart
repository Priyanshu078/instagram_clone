part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  final UserData userdata;
  final int tabIndex;
  final int postsIndex;
  const ProfileState(this.userdata, this.tabIndex, this.postsIndex);

  @override
  List<Object> get props => [userdata, tabIndex, postsIndex];
}

class ProfileLoading extends ProfileState {
  const ProfileLoading(super.userdata, super.tabIndex, super.postsIndex);
  @override
  List<Object> get props => [userdata, tabIndex, postsIndex];
}

class UserDataFetched extends ProfileState {
  const UserDataFetched(super.userdata, super.tabIndex, super.postsIndex);
  @override
  List<Object> get props => [userdata, tabIndex, postsIndex];
}

class UserDataEdited extends ProfileState {
  const UserDataEdited(super.userdata, super.tabIndex, super.postsIndex);
  @override
  List<Object> get props => [userdata, tabIndex, postsIndex];
}

class ProfilePhotoEdited extends ProfileState {
  const ProfilePhotoEdited(super.userdata, super.tabIndex, super.postsIndex);
  @override
  List<Object> get props => [userdata, tabIndex, postsIndex];
}

class ProfilePhotoLoading extends ProfileState {
  const ProfilePhotoLoading(super.userdata, super.tabIndex, super.postsIndex);
  @override
  List<Object> get props => [userdata, tabIndex, postsIndex];
}

class LogoutDoneState extends ProfileState {
  const LogoutDoneState(super.userdata, super.tabIndex, super.postsIndex);
  @override
  List<Object> get props => [userdata, tabIndex, postsIndex];
}

class ProfilePrivateState extends ProfileState {
  const ProfilePrivateState(super.userdata, super.tabIndex, super.postsIndex);

  @override
  List<Object> get props => [userdata, tabIndex, postsIndex];
}

class TabChangedState extends ProfileState {
  const TabChangedState(super.userdata, super.tabIndex, super.postsIndex);

  @override
  List<Object> get props => [userdata, tabIndex, postsIndex];
}

class PostIndexChangedState extends ProfileState {
  const PostIndexChangedState(super.userdata, super.tabIndex, super.postsIndex);

  @override
  List<Object> get props => [userdata, tabIndex, postsIndex];
}
