part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState(this.obscurePassword);
  final bool obscurePassword;
  @override
  List<Object> get props => [obscurePassword];
}

class AuthInitial extends AuthState {
  const AuthInitial(super.obscurePassword);

  @override
  List<Object> get props => [obscurePassword];
}

class ViewPassword extends AuthState {
  const ViewPassword(super.obscurePassword);

  @override
  List<Object> get props => [obscurePassword];
}
