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
