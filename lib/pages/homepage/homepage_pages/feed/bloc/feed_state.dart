part of 'feed_bloc.dart';

abstract class FeedState extends Equatable {
  const FeedState();
  
  @override
  List<Object> get props => [];
}

class FeedInitial extends FeedState {}
