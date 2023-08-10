import 'dart:io';
import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/data/posts_data.dart';
import 'package:instagram_clone/data/user_data.dart';
import 'package:instagram_clone/main.dart';
import 'package:instagram_clone/utility/notification_service.dart';
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
    var image = await ImagePicker().pickImage(
        source: event.fromCamera ? ImageSource.camera : ImageSource.gallery);
    if (image != null) {
      emit(PostReady(image.path));
    } else {
      emit(const PostsInitial(""));
    }
  }

  Future<void> postImage(PostImage event, Emitter emit) async {
    int id = Random().nextInt(100000);
    try {
      emit(PostingImageState(state.imagePath));
      await sendNotification(id);
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
      String postId = const Uuid().v4();
      Post post = Post(
          id: postId,
          username: username,
          imageUrl: imageUrl,
          likes: [],
          comments: [],
          caption: caption,
          userId: userId,
          userProfilePhotoUrl: event.userProfilePhotoUrl);
      List<Post> posts = userData.posts;
      List newPosts = posts.map((post) => post.toJson()).toList();
      newPosts.add(post.toJson());
      await fireStoreCollectionRef.doc(userId).update({"posts": newPosts});
      flutterLocalNotificationsPlugin.cancel(id);
      emit(const PostsInitial(""));
      String title = "New Post";
      String notificationImageUrl = "";
      String body = "$username just posted a photo";
      var snapshots = await FirebaseFirestore.instance
          .collection("users")
          .where("following", arrayContains: userId)
          .where("id", isNotEqualTo: userId)
          .get();
      List receiverFcmToken = List.generate(snapshots.docs.length,
          (index) => snapshots.docs[index].data()['fcmToken']);
      await NotificationService().sendNotification(
          title, notificationImageUrl, body, receiverFcmToken, true);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      flutterLocalNotificationsPlugin.cancel(id);
      emit(const PostsInitial(""));
    }
  }

  Future sendNotification(int id) async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
      "Instagram Channel Id",
      "Instagram Channel name",
      importance: Importance.max,
      priority: Priority.max,
      onlyAlertOnce: true,
      enableVibration: true,
      playSound: true,
      showProgress: true,
      category: AndroidNotificationCategory.progress,
      indeterminate: true,
    );
    DarwinNotificationDetails darwinNotificationDetails =
        const DarwinNotificationDetails();
    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
        id, "Posting...", "", notificationDetails);
  }
}
