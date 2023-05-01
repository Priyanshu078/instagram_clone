part of 'homepage_bloc.dart';

@immutable
abstract class HomepageState extends Equatable {
  final int index;

  const HomepageState(this.index);

  @override
  List<Object?> get props => [index];
}

class HomepageInitial extends HomepageState {
  const HomepageInitial(super.index);
  @override
  List<Object?> get props => [index];
}

class TabChanged extends HomepageState {
  const TabChanged(super.index);

  @override
  List<Object?> get props => [index];
}
