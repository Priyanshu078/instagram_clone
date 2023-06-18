import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/data/comment_data.dart';
import 'package:instagram_clone/data/posts_data.dart';
import 'package:instagram_clone/data/user_data.dart';
import 'package:instagram_clone/pages/homepage/bloc/homepage_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

import 'package:uuid/uuid.dart';
part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(this.pageController)
      : super(ProfileLoading(UserData.temp(), 0, 0)) {
    on<GetUserDetails>((event, emit) => getUserDetails(event, emit));
    on<EditUserDetails>((event, emit) => editUserDetails(event, emit));
    on<ChangeProfilePhotoEvent>(
        (event, emit) => changeProfilePhotoEvent(event, emit));
    on<LogoutEvent>((event, emit) => logout(event, emit));
    on<ProfilePrivateEvent>((event, emit) => changeProfileStatus(event, emit));
    on<TabChangeEvent>((event, emit) => emit(
        TabChangedState(state.userData, event.tabIndex, state.postsIndex)));
    on<PostsIndexChangeEvent>((event, emit) => emit(PostIndexChangedState(
        state.userData, state.tabIndex, event.postIndex)));
    on<LikePostEvent>((event, emit) => likePost(event, emit));
    on<AddProfileComment>((event, emit) => addComment(event, emit));
    on<DeleteProfileComment>((event, emit) => deleteComment(event, emit));
  }

  final PageController pageController;

  Future<void> addComment(AddProfileComment event, Emitter emit) async {
    List<Comments> existingcomments = List.from(event.comments);
    String userId = state.userData.id;
    String profilePhotoUrl = state.userData.profilePhotoUrl;
    String username = state.userData.username;
    String id = const Uuid().v4();
    Comments newComment =
        Comments(event.comment, profilePhotoUrl, username, userId, id);
    existingcomments.add(newComment);
    List<Post> posts = List.from(state.userData.posts);
    posts[event.postIndex] = state.userData.posts[event.postIndex]
        .copyWith(comments: existingcomments);
    UserData userData = state.userData.copyWith(posts: posts);
    await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .update(userData.toJson());
    emit(CommentAddedProfileState(userData, state.tabIndex, state.postsIndex));
  }

  Future<void> deleteComment(DeleteProfileComment event, Emitter emit) async {
    List<Comments> exisitingComments =
        List.from(state.userData.posts[event.postIndex].comments);
    exisitingComments.removeAt(event.commentIndex);
    List<Post> posts = state.userData.posts;
    posts[event.postIndex] = state.userData.posts[event.postIndex]
        .copyWith(comments: exisitingComments);
    UserData userData = state.userData.copyWith(posts: posts);
    String userId = state.userData.id;
    await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .update(userData.toJson());
    emit(
        DeletedCommentProfileState(userData, state.tabIndex, state.postsIndex));
  }

  Future<void> likePost(LikePostEvent event, Emitter emit) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? userId = sharedPreferences.getString("userId");
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    final collectionRef = firebaseFirestore.collection("users");
    var documentData = collectionRef.doc(userId);
    List<Post> posts = List.from(state.userData.posts);
    List likes = posts[event.index].likes;
    if (likes.contains(userId)) {
      likes.remove(userId);
    } else {
      likes.add(userId);
    }
    posts[event.index] =
        state.userData.posts[event.index].copyWith(likes: likes);
    UserData userData = state.userData.copyWith(posts: posts);
    emit(PostLikedState(userData, state.tabIndex, state.postsIndex));
    var value = await documentData.get();
    var data = value.data()!;
    data["posts"][event.index]["likes"] = likes;
    await documentData.update(data);
  }

  Future<void> changeProfileStatus(
      ProfilePrivateEvent event, Emitter emit) async {
    var firestoreCollectionRef = FirebaseFirestore.instance.collection('users');
    await firestoreCollectionRef
        .doc(event.userData.id)
        .update({"private": event.userData.private});
    emit(ProfilePrivateState(event.userData, state.tabIndex, state.postsIndex));
  }

  Future<void> logout(LogoutEvent event, Emitter emit) async {
    var sharedPrefernces = await SharedPreferences.getInstance();
    await sharedPrefernces.clear();
    emit(LogoutDoneState(state.userData, state.tabIndex, state.postsIndex));
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
    emit(UserDataFetched(userData, state.tabIndex, state.postsIndex));
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
    emit(UserDataEdited(event.userData, state.tabIndex, state.postsIndex));
  }

  Future<void> changeProfilePhotoEvent(
      ChangeProfilePhotoEvent event, Emitter emit) async {
    emit(ProfilePhotoLoading(
        event.userData.copyWith(), state.tabIndex, state.postsIndex));
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
    emit(ProfilePhotoEdited(userData, state.tabIndex, state.postsIndex));
  }
}
