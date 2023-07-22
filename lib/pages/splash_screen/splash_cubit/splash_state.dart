import 'package:equatable/equatable.dart';

abstract class SplashState extends Equatable {
  final bool dataSaved;
  final String userId;
  const SplashState(this.dataSaved, this.userId);
  @override
  List<Object?> get props => [dataSaved, userId];
}

class SplashInitial extends SplashState {
  const SplashInitial(super.dataSaved, super.userId);
  @override
  List<Object?> get props => [dataSaved, userId];
}
