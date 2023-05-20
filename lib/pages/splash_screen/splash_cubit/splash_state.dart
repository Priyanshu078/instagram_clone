import 'package:equatable/equatable.dart';

abstract class SplashState extends Equatable {
  final bool dataSaved;
  const SplashState(this.dataSaved);
  @override
  List<Object?> get props => [dataSaved];
}

class SplashInitial extends SplashState {
  const SplashInitial(super.dataSaved);
  @override
  List<Object?> get props => [dataSaved];
}
