import 'dart:io';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/data/user_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileLoading(UserData.temp())) {
    on<GetUserDetails>((event, emit) => getUserDetails(event, emit));
    on<EditUserDetails>((event, emit) => editUserDetails(event, emit));
    on<ChangeProfilePhotoEvent>(
        (event, emit) => changeProfilePhotoEvent(event, emit));
  }

  Future<void> getUserDetails(GetUserDetails event, Emitter emit) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    var userId = sharedPreferences.getString("userId");
    var collectionRef = FirebaseFirestore.instance.collection("users");
    Query<Map<String, dynamic>> queriedData =
        collectionRef.where("id", isEqualTo: userId);
    var snapshotData = await queriedData.get();
    UserData userData = UserData.fromJson(snapshotData.docs.first.data());
    print(userData);
    emit(UserDataFetched(userData));
  }

  Future<void> editUserDetails(EditUserDetails event, Emitter emit) async {
    var collectionRef = FirebaseFirestore.instance.collection("users");
    await collectionRef.doc(event.userData.id).set(event.userData.toJson());
    emit(UserDataEdited(event.userData));
  }

  Future<void> changeProfilePhotoEvent(
      ChangeProfilePhotoEvent event, Emitter emit) async {
    var profileImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    var storageRef = FirebaseStorage.instance.ref();
    Reference imagesRef = storageRef.child(event.userData.id);
    const fileName = "profilePhoto.jpg";
    final profilePhotoRef = imagesRef.child(fileName);
    // final path = profilePhotoRef.fullPath;
    final imagePath = await profilePhotoRef.getDownloadURL();
    File image = File(profileImage!.path);
    await profilePhotoRef.putFile(image);
    await FirebaseFirestore.instance
        .collection("users")
        .doc(event.userData.id)
        .update({"profilePhotoUrl": imagePath});
    // UserData userData = UserData(
    //     event.userData.id,
    //     event.userData.name,
    //     event.userData.username,
    //     event.userData.contact,
    //     event.userData.password,
    //     event.userData.gender,
    //     event.userData.bio,
    //     event.userData.tagline,
    //     event.userData.posts,
    //     event.userData.stories,
    //     event.userData.followers,
    //     event.userData.following,
    //     imagePath);
    UserData userData = event.userData.copyWith(profilePhotoUrl: imagePath);
    emit(ProfilePhotoEdited(userData));
  }
}
