import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:instagram_clone/data/user_data.dart';
import 'package:instagram_clone/main.dart';
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
    on<ResetPasswordEvent>((event, emit) => resetPassword(event, emit));
  }

  Future<void> resetPassword(ResetPasswordEvent event, Emitter emit) async {
    emit(ResettingPasswordState(state.obscurePassword, state.gender));
    String username = event.username;
    String email = event.email;
    String newPassword = event.password;
    var collectionRef = FirebaseFirestore.instance.collection("users");
    var docSnapshot = await collectionRef
        .where("username", isEqualTo: username)
        .where("contact", isEqualTo: email)
        .get();
    await collectionRef
        .doc(docSnapshot.docs[0].id)
        .update({"password": newPassword});
    emit(PasswordResetSuccessState(state.obscurePassword, state.gender));
  }

  Future<void> signUp(RequestSignUpEvent event, Emitter emit) async {
    emit(LoadingState(state.obscurePassword, state.gender));
    try {
      UserData data = event.userData.copyWith(fcmToken: fcmToken!);
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
        await FirebaseFirestore.instance
            .collection("stories")
            .doc(userData.id)
            .set({
          "addedStory": false,
          "userId": userData.id,
          "previous_stories": [],
          "viewed": false,
        });
        await FirebaseFirestore.instance
            .collection("notifications")
            .doc(userData.id)
            .set({"notifications": [], "new_notifications": false});
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
          if (kDebugMode) {
            print(userData.gender);
            print(userData.name);
          }
          var sharedPreferences = await SharedPreferences.getInstance();
          await sharedPreferences.setString("userId", userData.id);
          await sharedPreferences.setString(
              "profilePhotoUrl", userData.profilePhotoUrl);
          await sharedPreferences.setString("username", userData.username);
          await FirebaseFirestore.instance
              .collection("users")
              .doc(userData.id)
              .update({"fcmToken": fcmToken});
          if (kDebugMode) {
            print("UserId: ${sharedPreferences.getString("userId")}");
          }
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
