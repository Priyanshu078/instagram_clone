part of 'homepage_bloc.dart';

@immutable
abstract class HomepageEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class TabChange extends HomepageEvent {
  final int index;

  TabChange(this.index);

  @override
  List<Object?> get props => [index];
}

class GetDetails extends HomepageEvent {}

class RefreshUi extends HomepageEvent {
  final String imageUrl;
  RefreshUi(this.imageUrl);
  @override
  List<Object?> get props => [imageUrl];
}

class SeenNewNotification extends HomepageEvent {}
