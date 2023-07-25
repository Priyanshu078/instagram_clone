part of 'notification_bloc.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object> get props => [];
}

class NotificationsInitialState extends NotificationState {}

class NotificationsFetchedState extends NotificationState {}
