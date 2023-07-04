part of 'story_bloc.dart';

abstract class StoryState extends Equatable {
  const StoryState(this.imagePath);
  final String imagePath;
  @override
  List<Object> get props => [];
}

class StoryInitial extends StoryState {
  const StoryInitial(super.imagePath);

  @override
  List<Object> get props => [imagePath];
}

class StoryReadyState extends StoryState {
  const StoryReadyState(super.imagePath);

  @override
  List<Object> get props => [imagePath];
}

class StoryPosted extends StoryState {
  const StoryPosted(super.imagePath);

  @override
  List<Object> get props => [imagePath];
}

class StoryPostingState extends StoryState {
  const StoryPostingState(super.imagePath);
  @override
  List<Object> get props => [imagePath];
}

class StoryDeleted extends StoryState {
  const StoryDeleted(super.imagePath);
  @override
  List<Object> get props => [imagePath];
}

class DeletingStoryState extends StoryState {
  const DeletingStoryState(super.imagePath);
  @override
  List<Object> get props => [imagePath];
}
