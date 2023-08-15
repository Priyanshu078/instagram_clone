import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'homepage_event.dart';
part 'homepage_state.dart';

class HomepageBloc extends Bloc<HomepageEvent, HomepageState> {
  HomepageBloc() : super(const HomePageLoadingState(0, false)) {
    on<TabChange>(
        (event, emit) => emit(TabChanged(event.index, state.newNotifications)));
    on<GetDetails>((event, emit) => getDetails(event, emit));
    on<RefreshUi>((event, emit) =>
        emit(HomepageInitial(state.index, state.newNotifications)));
    on<SeenNewNotification>(
        (event, emit) => setNewNotificationsStatus(event, emit));
  }

  late final SharedPreferences sharedPreferences;

  Future<void> setNewNotificationsStatus(
      SeenNewNotification event, Emitter emit) async {
    String? userId = sharedPreferences.getString("userId");
    if (state.newNotifications) {
      await FirebaseFirestore.instance
          .collection("notifications")
          .doc(userId)
          .update({"new_notifications": false});
      emit(HomepageInitial(state.index, false));
    }
  }

  Future<void> getDetails(GetDetails event, Emitter emit) async {
    sharedPreferences = await SharedPreferences.getInstance();
    var userId = sharedPreferences.getString("userId");
    var collectionRef = FirebaseFirestore.instance.collection("notifications");
    var notificationData = await collectionRef.doc(userId).get();
    bool newNotifications = false;
    if (notificationData.data() == null) {
      await collectionRef
          .doc(userId)
          .set({"notifications": [], "new_notifications": false});
    } else {
      newNotifications = notificationData.data()!['new_notifications'];
    }
    emit(HomepageInitial(state.index, newNotifications));
  }
}
