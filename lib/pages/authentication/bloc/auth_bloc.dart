import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:instagram_clone/data/user_data.dart';
import 'package:instagram_clone/pages/authentication/auth_pages/signup_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    try {
      UserData data = event.userData;
      if (data.contact.isNotEmpty &&
          data.name.isNotEmpty &&
          data.password.isNotEmpty &&
          data.username.isNotEmpty) {
        var firebaseStorageRef = FirebaseStorage.instance.ref();
        String fileName = "profilePhoto.jpg";
        var profilePhotoUrl =
            await firebaseStorageRef.child(fileName).getDownloadURL();
        UserData userData = data.copyWith(profilePhotoUrl: profilePhotoUrl);
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userData.id)
            .set(userData.toJson());
        emit(SignUpDone(state.obscurePassword, state.gender));
      } else {
        emit(FillAllDetails(state.obscurePassword, state.gender));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      emit(ErrorState(state.obscurePassword, state.gender));
    }
  }

  Future<void> login(RequestLoginEvent event, Emitter emit) async {
    emit(LoadingState(state.obscurePassword, state.gender));
    try {
      if (event.password.isNotEmpty && event.username.isNotEmpty) {
        Query<Map<String, dynamic>> userdata = FirebaseFirestore.instance
            .collection('users')
            .where('username', isEqualTo: event.username)
            .where('password', isEqualTo: event.password);
        var snapshotData = await userdata.get();
        List docsList = snapshotData.docs;
        if (docsList.isNotEmpty) {
          UserData userData = UserData.fromJson(docsList.first.data());
          print(userData.gender);
          print(userData.name);
          var sharedPreferences = await SharedPreferences.getInstance();
          await sharedPreferences.setString("userId", userData.id);
          print("UserId: ${sharedPreferences.getString("userId")}");
          emit(LoginDone(state.obscurePassword, state.gender));
        } else {
          emit(UserDataNotAvailable(state.obscurePassword, state.gender));
        }
      } else {
        emit(FillAllDetails(state.obscurePassword, state.gender));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      emit(ErrorState(state.obscurePassword, state.gender));
    }
  }
}
