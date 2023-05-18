import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:instagram_clone/data/user_data.dart';
import 'package:instagram_clone/pages/authentication/auth_pages/signup_page.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthInitial(true, Gender.other)) {
    on<ShowPassword>(
        (event, emit) => emit(ViewPassword(event.status, state.gender)));
    on<ChangeGender>((event, emit) =>
        emit(ChangedGender(state.obscurePassword, event.gender)));
    on<RequestSignUpEvent>((event, emit) => signUp(event, emit));
    on<RequestLoginEvent>((event, emit) => login(event, emit));
  }

  Future<void> signUp(RequestSignUpEvent event, Emitter emit) async {
    emit(LoadingState(state.obscurePassword, state.gender));
    await FirebaseFirestore.instance
        .collection('users')
        .doc(event.userData.id)
        .set(event.userData.toJson());
    emit(SignUpDone(state.obscurePassword, state.gender));
  }

  Future<void> login(RequestLoginEvent event, Emitter emit) async {
    if (event.password.isNotEmpty && event.username.isNotEmpty) {
      emit(LoadingState(state.obscurePassword, state.gender));
      Query<Map> userdata = FirebaseFirestore.instance
          .collection('users')
          .where('username', isEqualTo: event.username)
          .where('password', isEqualTo: event.password);
      var snapshotData = await userdata.get();
      List docsList = snapshotData.docs;
      if (docsList.isNotEmpty) {
        UserData userData = UserData.fromJson(docsList.first.data());
        print(userData.gender);
        print(userData.name);
        emit(LoginDone(state.obscurePassword, state.gender));
      } else {
        emit(UserDataNotAvailable(state.obscurePassword, state.gender));
      }
    } else {
      emit(FillAllDetails(state.obscurePassword, state.gender));
      emit(AuthInitial(state.obscurePassword, state.gender));
    }
  }
}
