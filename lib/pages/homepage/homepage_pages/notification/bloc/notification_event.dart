part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

class NotificationsInitial extends NotificationEvent {}

class NotificationsFetched extends NotificationEvent {}
