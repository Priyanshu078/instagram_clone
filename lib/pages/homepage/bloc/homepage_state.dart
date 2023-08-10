part of 'homepage_bloc.dart';

@immutable
abstract class HomepageState extends Equatable {
  final int index;
  final bool newNotifications;

  const HomepageState(this.index, this.newNotifications);

  @override
  List<Object?> get props => [index, newNotifications];
}

class HomepageInitial extends HomepageState {
  const HomepageInitial(super.index, super.newNotifications);
  @override
  List<Object?> get props => [index, newNotifications];
}

class TabChanged extends HomepageState {
  const TabChanged(super.index, super.newNotifications);

  @override
  List<Object?> get props => [index, newNotifications];
}

class HomePageLoadingState extends HomepageState {
  const HomePageLoadingState(super.index, super.newNotifications);

  @override
  List<Object?> get props => [index, newNotifications];
}
