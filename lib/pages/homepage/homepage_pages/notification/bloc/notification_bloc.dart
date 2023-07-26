import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:instagram_clone/data/notification_data.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(const NotificationsInitialState([])) {
    on<FetchNotifications>((event, emit) => fetchNotifications(event, emit));
  }

  Future<void> fetchNotifications(
      FetchNotifications event, Emitter emit) async {
    emit(const NotificationsInitialState([]));
    List<Notification> notifications = [];
    emit(NotificationsFetchedState(notifications));
  }
}
