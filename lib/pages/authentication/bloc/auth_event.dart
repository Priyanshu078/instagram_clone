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
