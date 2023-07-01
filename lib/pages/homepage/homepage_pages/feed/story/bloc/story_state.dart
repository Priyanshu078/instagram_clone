part of 'story_bloc.dart';

abstract class StoryState extends Equatable {
  const StoryState();
  
  @override
  List<Object> get props => [];
}

class StoryInitial extends StoryState {}
