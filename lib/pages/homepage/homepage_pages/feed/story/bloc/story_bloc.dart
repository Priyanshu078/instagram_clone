import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/data/stories.dart';
import 'package:instagram_clone/main.dart';
import 'package:instagram_clone/utility/notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
part 'story_event.dart';
part 'story_state.dart';

class StoryBloc extends Bloc<StoryEvent, StoryState> {
  StoryBloc() : super(const StoryInitial("")) {
    on<ChooseImageEvent>((event, emit) => chooseImage(event, emit));
    on<CancelEvent>((event, emit) => emit(const StoryInitial("")));
    on<PostStory>((event, emit) => postStory(event, emit));
    on<DeleteStory>((event, emit) => deleteStory(event, emit));
  }

  Future<void> deleteStory(DeleteStory event, Emitter emit) async {
    emit(const DeletingStoryState(""));
    var sharedPreferences = await SharedPreferences.getInstance();
    String? userId = sharedPreferences.getString("userId");
    await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .update({"addedStory": false});
    var collectionRef = FirebaseFirestore.instance.collection("stories");
    var docSnapshot = await collectionRef.doc(userId).get();
    var docData = docSnapshot.data()!;
    List previousStories = docData['previous_stories'];
    previousStories.removeLast();
    await collectionRef
        .doc(userId)
        .update({"previous_stories": previousStories, "addedStory": false});
    emit(const StoryDeleted(""));
  }

  Future<void> chooseImage(ChooseImageEvent event, Emitter emit) async {
    var image = await ImagePicker().pickImage(
        source: event.fromGallery ? ImageSource.gallery : ImageSource.camera);
    if (image != null) {
      emit(StoryReadyState(image.path));
    } else {
      emit(const StoryInitial(""));
    }
  }

  Future<void> postStory(PostStory event, Emitter emit) async {
    int id = Random().nextInt(100000);
    try {
      emit(StoryPostingState(state.imagePath));
      sendNotification(id);
      var sharedPreferences = await SharedPreferences.getInstance();
      String? userId = sharedPreferences.getString("userId");
      String? userProfilePhotoUrl =
          sharedPreferences.getString("profilePhotoUrl");
      String? username = sharedPreferences.getString("username");
      String storyId = const Uuid().v4();
      String caption = event.caption;
      String date = DateTime.now().toString().split(" ")[0];
      var firebaseStorageRef = FirebaseStorage.instance.ref();
      var childRef = firebaseStorageRef.child(userId!);
      String hash = const Uuid().v4();
      String imageName = "stories/story$hash.jpg";
      var imageLocationRef = childRef.child(imageName);
      File image = File(state.imagePath);
      await imageLocationRef.putFile(image);
      var imageUrl = await imageLocationRef.getDownloadURL();
      Story story = Story(
          id: storyId,
          userProfilePhotoUrl: userProfilePhotoUrl!,
          username: username!,
          imageUrl: imageUrl,
          caption: caption,
          userId: userId,
          date: date);
      var collectionRef = FirebaseFirestore.instance.collection("stories");
      var docSnapshot = await collectionRef.doc(userId).get();
      var docData = docSnapshot.data();
      if (docData == null) {
        await collectionRef.doc(userId).set({
          "addedStory": false,
          "userId": userId,
          "previous_stories": [],
          "viewed": false,
        });
      }
      List previousStories = docData == null ? [] : docData["previous_stories"];
      previousStories.add(story.toJson());
      await collectionRef
          .doc(userId)
          .update({"previous_stories": previousStories, "addedStory": true});
      await FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .update({"addedStory": true});
      flutterLocalNotificationsPlugin.cancel(id);
      emit(const StoryPosted(""));
      String title = "New Story";
      String notificationImageUrl = "";
      String body = "$username added to their story";
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
      emit(const StoryInitial(""));
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
