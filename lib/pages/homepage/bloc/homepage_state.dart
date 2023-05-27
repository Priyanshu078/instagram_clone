part of 'homepage_bloc.dart';

@immutable
abstract class HomepageState extends Equatable {
  final int index;
  final HomePageData homePageData;

  const HomepageState(this.index, this.homePageData);

  @override
  List<Object?> get props => [index, homePageData];
}

class HomepageInitial extends HomepageState {
  const HomepageInitial(super.index, super.homePageData);
  @override
  List<Object?> get props => [index, homePageData];
}

class TabChanged extends HomepageState {
  const TabChanged(super.index, super.homePageData);

  @override
  List<Object?> get props => [index, homePageData];
}

class HomePageLoadingState extends HomepageState {
  const HomePageLoadingState(super.index, super.imageUrl);

  @override
  List<Object?> get props => [index, homePageData];
}
