part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  final UserData userdata;
  const ProfileState(this.userdata);

  @override
  List<Object> get props => [userdata];
}

class ProfileLoading extends ProfileState {
  const ProfileLoading(super.userdata);
  @override
  List<Object> get props => [userdata];
}

class UserDataFetched extends ProfileState {
  const UserDataFetched(super.userdata);
  @override
  List<Object> get props => [userdata];
}

class UserDataEdited extends ProfileState {
  const UserDataEdited(super.userdata);
  @override
  List<Object> get props => [userdata];
}

class ProfilePhotoEdited extends ProfileState {
  const ProfilePhotoEdited(super.userdata);
  @override
  List<Object> get props => [userdata];
}

class ProfilePhotoLoading extends ProfileState {
  const ProfilePhotoLoading(super.userdata);
  @override
  List<Object> get props => [userdata];
}

class LogoutDoneState extends ProfileState {
  const LogoutDoneState(super.userdata);
  @override
  List<Object> get props => [userdata];
}

class ProfilePrivateState extends ProfileState {
  const ProfilePrivateState(super.userdata);

  @override
  List<Object> get props => [userdata];
}
