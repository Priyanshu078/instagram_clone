part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState(this.obscurePassword, this.gender);
  final bool obscurePassword;
  final Gender gender;
  @override
  List<Object> get props => [obscurePassword, gender];
}

class AuthInitial extends AuthState {
  const AuthInitial(super.obscurePassword, super.gender);

  @override
  List<Object> get props => [obscurePassword, gender];
}

class ViewPassword extends AuthState {
  const ViewPassword(super.obscurePassword, super.gender);

  @override
  List<Object> get props => [obscurePassword, gender];
}

class ChangedGender extends AuthState {
  const ChangedGender(super.obscurePassword, super.gender);

  @override
  List<Object> get props => [obscurePassword, gender];
}

class LoadingState extends AuthState {
  const LoadingState(super.obscurePassword, super.gender);

  @override
  List<Object> get props => [obscurePassword, gender];
}

class SignUpDone extends AuthState {
  const SignUpDone(super.obscurePassword, super.gender);

  @override
  List<Object> get props => [obscurePassword, gender];
}

class LoginDone extends AuthState {
  const LoginDone(super.obscurePassword, super.gender);

  @override
  List<Object> get props => [obscurePassword, gender];
}
