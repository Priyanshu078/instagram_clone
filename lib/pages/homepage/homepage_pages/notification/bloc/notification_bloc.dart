import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:instagram_clone/data/notification_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(const NotificationsInitialState([])) {
    on<FetchNotifications>((event, emit) => fetchNotifications(event, emit));
  }

  Future<void> fetchNotifications(
      FetchNotifications event, Emitter emit) async {
    emit(const NotificationsInitialState([]));
    var sharedPreferences = await SharedPreferences.getInstance();
    String? userId = sharedPreferences.getString("userId");
    var collectionRef = FirebaseFirestore.instance.collection("notifications");
    var snapshots = await collectionRef.doc(userId).get();
    if (snapshots.data() == null) {
      emit(const NotificationsFetchedState([]));
      await collectionRef
          .doc(userId)
          .set({"notifications": [], "new_notifications": false});
    } else {
      List data = snapshots.data()!["notifications"];
      List<NotificationData> notifications = List.generate(data.length,
          (index) => NotificationData.fromJson(data[data.length - 1 - index]));
      emit(NotificationsFetchedState(notifications));
    }
  }
}
