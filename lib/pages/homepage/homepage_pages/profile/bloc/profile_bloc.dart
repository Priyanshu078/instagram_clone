import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/data/user_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileLoading(UserData.temp(), 0)) {
    on<GetUserDetails>((event, emit) => getUserDetails(event, emit));
    on<EditUserDetails>((event, emit) => editUserDetails(event, emit));
    on<ChangeProfilePhotoEvent>(
        (event, emit) => changeProfilePhotoEvent(event, emit));
    on<LogoutEvent>((event, emit) => logout(event, emit));
    on<ProfilePrivateEvent>((event, emit) => changeProfileStatus(event, emit));
    on<TabChangeEvent>(
        (event, emit) => emit(TabChangedState(state.userdata, event.tabIndex)));
  }

  Future<void> changeProfileStatus(
      ProfilePrivateEvent event, Emitter emit) async {
    var firestoreCollectionRef = FirebaseFirestore.instance.collection('users');
    await firestoreCollectionRef
        .doc(event.userData.id)
        .update({"private": event.userData.private});
    emit(ProfilePrivateState(event.userData, state.tabIndex));
  }

  Future<void> logout(LogoutEvent event, Emitter emit) async {
    var sharedPrefernces = await SharedPreferences.getInstance();
    await sharedPrefernces.clear();
    emit(LogoutDoneState(state.userdata, state.tabIndex));
  }

  Future<void> getUserDetails(GetUserDetails event, Emitter emit) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    var userId = sharedPreferences.getString("userId");
    var collectionRef = FirebaseFirestore.instance.collection("users");
    Query<Map<String, dynamic>> queriedData =
        collectionRef.where("id", isEqualTo: userId);
    var snapshotData = await queriedData.get();
    UserData userData = UserData.fromJson(snapshotData.docs.first.data());
    if (kDebugMode) {
      print(userData);
    }
    emit(UserDataFetched(userData, state.tabIndex));
  }

  Future<void> editUserDetails(EditUserDetails event, Emitter emit) async {
    var collectionRef = FirebaseFirestore.instance.collection("users");
    await collectionRef.doc(event.userData.id).update({
      "name": event.userData.name,
      "username": event.userData.username,
      "tagline": event.userData.tagline,
      "bio": event.userData.bio,
      "profilePhotoUrl": event.userData.profilePhotoUrl,
    });
    emit(UserDataEdited(event.userData, state.tabIndex));
  }

  Future<void> changeProfilePhotoEvent(
      ChangeProfilePhotoEvent event, Emitter emit) async {
    emit(ProfilePhotoLoading(event.userData.copyWith(), state.tabIndex));
    var profileImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    var storageRef = FirebaseStorage.instance.ref();
    Reference imagesRef = storageRef.child(event.userData.id);
    const fileName = "profilePhoto.jpg";
    final profilePhotoRef = imagesRef.child(fileName);
    // final path = profilePhotoRef.fullPath;
    File image = File(profileImage!.path);
    await profilePhotoRef.putFile(image);
    final imagePath = await profilePhotoRef.getDownloadURL();
    await FirebaseFirestore.instance
        .collection("users")
        .doc(event.userData.id)
        .update({"profilePhotoUrl": imagePath});
    UserData userData = event.userData.copyWith(profilePhotoUrl: imagePath);
    emit(ProfilePhotoEdited(userData, state.tabIndex));
  }
}
