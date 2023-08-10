part of 'notification_bloc.dart';

abstract class NotificationState extends Equatable {
  const NotificationState(this.notifications);
  final List<NotificationData> notifications;
  @override
  List<Object> get props => [notifications];
}

class NotificationsInitialState extends NotificationState {
  const NotificationsInitialState(super.notifications);
  @override
  List<Object> get props => [notifications];
}

class NotificationsFetchedState extends NotificationState {
  const NotificationsFetchedState(super.notifications);
  @override
  List<Object> get props => [notifications];
}
