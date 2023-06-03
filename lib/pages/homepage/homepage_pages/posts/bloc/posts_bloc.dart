import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/data/posts_data.dart';
import 'package:instagram_clone/data/user_data.dart';
import 'package:instagram_clone/widgets/insta_snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc() : super(const PostsInitial("")) {
    on<ChooseImage>((event, emit) => chooseImage(event, emit));
    on<CancelEvent>((event, emit) => emit(const PostsInitial("")));
    on<PostImage>((event, emit) => postImage(event, emit));
  }

  Future<void> chooseImage(ChooseImage event, Emitter emit) async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      emit(PostReady(image.path));
    } else {
      emit(const PostsInitial(""));
    }
  }

  Future<void> postImage(PostImage event, Emitter emit) async {
    try {
      emit(PostingImageState(state.imagePath));
      var sharedPreferences = await SharedPreferences.getInstance();
      var userId = sharedPreferences.getString('userId');
      var caption = event.caption;
      var fireStoreCollectionRef =
          FirebaseFirestore.instance.collection("users");
      var userDocumentData = await fireStoreCollectionRef.doc(userId).get();
      UserData userData = UserData.fromJson(userDocumentData.data()!);
      String username = userData.username;
      var fireStorageRef = FirebaseStorage.instance.ref();
      Reference childRef = fireStorageRef.child(userId!);
      var hash = const Uuid().v4();
      String imageName = "posts/post$hash.jpg";
      var imageLocationRef = childRef.child(imageName);
      File image = File(state.imagePath);
      await imageLocationRef.putFile(image);
      var imageUrl = await imageLocationRef.getDownloadURL();
      Post post = Post(
        username: username,
        imageUrl: imageUrl,
        likes: 0,
        comments: [],
        caption: caption,
      );
      List<Post> posts = userData.posts;
      List newPosts = posts.map((post) => post.toJson()).toList();
      newPosts.add(post.toJson());
      await fireStoreCollectionRef.doc(userId).update({"posts": newPosts});
      emit(const PostsInitial(""));
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      emit(const PostsInitial(""));
    }
  }
}
