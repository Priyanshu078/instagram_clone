part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class ShowPassword extends AuthEvent {
  final bool status;
  const ShowPassword(this.status);
  @override
  List<Object> get props => [status];
}

class ChangeGender extends AuthEvent {
  final Gender gender;
  const ChangeGender(this.gender);
  @override
  List<Object> get props => [gender];
}

class RequestSignUpEvent extends AuthEvent {
  final UserData userData;
  const RequestSignUpEvent(this.userData);
  @override
  List<Object> get props => [userData];
}

class RequestLoginEvent extends AuthEvent {
  final String username;
  final String password;
  const RequestLoginEvent(this.username, this.password);
  @override
  List<Object> get props => [username, password];
}

class ResetPasswordEvent extends AuthEvent {
  final String email;
  final String username;
  final String password;
  const ResetPasswordEvent(
      {required this.email, required this.username, required this.password});

  @override
  List<Object> get props => [username, password, email];
}
