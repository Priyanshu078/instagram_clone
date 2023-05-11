import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:instagram_clone/pages/authentication/auth_pages/signup_page.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthInitial(true, Gender.other)) {
    on<ShowPassword>(
        (event, emit) => emit(ViewPassword(event.status, state.gender)));
    on<ChangeGender>((event, emit) =>
        emit(ChangedGender(state.obscurePassword, event.gender)));
  }
}
