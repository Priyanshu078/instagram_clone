part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  final UserData userdata;
  final int tabIndex;
  const ProfileState(this.userdata, this.tabIndex);

  @override
  List<Object> get props => [userdata, tabIndex];
}

class ProfileLoading extends ProfileState {
  const ProfileLoading(super.userdata, super.tabIndex);
  @override
  List<Object> get props => [userdata, tabIndex];
}

class UserDataFetched extends ProfileState {
  const UserDataFetched(super.userdata, super.tabIndex);
  @override
  List<Object> get props => [userdata, tabIndex];
}

class UserDataEdited extends ProfileState {
  const UserDataEdited(super.userdata, super.tabIndex);
  @override
  List<Object> get props => [userdata, tabIndex];
}

class ProfilePhotoEdited extends ProfileState {
  const ProfilePhotoEdited(super.userdata, super.tabIndex);
  @override
  List<Object> get props => [userdata, tabIndex];
}

class ProfilePhotoLoading extends ProfileState {
  const ProfilePhotoLoading(super.userdata, super.tabIndex);
  @override
  List<Object> get props => [userdata, tabIndex];
}

class LogoutDoneState extends ProfileState {
  const LogoutDoneState(super.userdata, super.tabIndex);
  @override
  List<Object> get props => [userdata, tabIndex];
}

class ProfilePrivateState extends ProfileState {
  const ProfilePrivateState(super.userdata, super.tabIndex);

  @override
  List<Object> get props => [userdata, tabIndex];
}

class TabChangedState extends ProfileState {
  const TabChangedState(super.userdata, super.tabIndex);

  @override
  List<Object> get props => [userdata, tabIndex];
}
