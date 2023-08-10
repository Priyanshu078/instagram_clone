import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/homepage_data.dart';
part 'homepage_event.dart';
part 'homepage_state.dart';

class HomepageBloc extends Bloc<HomepageEvent, HomepageState> {
  HomepageBloc() : super(const HomePageLoadingState(0, false)) {
    on<TabChange>(
        (event, emit) => emit(TabChanged(event.index, state.newNotifications)));
    on<GetDetails>((event, emit) => getDetails(event, emit));
    on<RefreshUi>((event, emit) =>
        emit(HomepageInitial(state.index, state.newNotifications)));
  }

  late final SharedPreferences sharedPreferences;

  Future<void> getDetails(GetDetails event, Emitter emit) async {
    sharedPreferences = await SharedPreferences.getInstance();
    var userId = sharedPreferences.getString("userId");
    // var storageRef = FirebaseStorage.instance.ref();
    // const fileName = "profilePhoto.jpg";
    // try {
    //   Reference imagesRef = storageRef.child(userId!);
    //   final profilePhotoRef = imagesRef.child(fileName);
    //   final imagePath = await profilePhotoRef.getDownloadURL();
    //   HomePageData homePageData = HomePageData(imagePath);
    //   var notificationData = await FirebaseFirestore.instance
    //       .collection("notifications")
    //       .doc(sharedPreferences.getString("userId"))
    //       .get();
    //   var newNotifications = notificationData.data()!['new_notifications'];
    //   emit(HomepageInitial(state.index, homePageData, newNotifications));
    // } catch (e) {
    //   if (kDebugMode) {
    //     print(e);
    //   }
    // var imagePath = await storageRef.child(fileName).getDownloadURL();
    // HomePageData homePageData = HomePageData(imagePath);
    var notificationData = await FirebaseFirestore.instance
        .collection("notifications")
        .doc(userId)
        .get();
    var newNotifications = notificationData.data()!['new_notifications'];
    emit(HomepageInitial(state.index, newNotifications));
  }
}
