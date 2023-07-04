part of 'story_bloc.dart';

abstract class StoryEvent extends Equatable {
  const StoryEvent();
  @override
  List<Object> get props => [];
}

class ChooseImageEvent extends StoryEvent {
  final bool fromGallery;
  const ChooseImageEvent(this.fromGallery);
  @override
  List<Object> get props => [fromGallery];
}

class CancelEvent extends StoryEvent {}

class PostStory extends StoryEvent {
  final String caption;
  const PostStory(this.caption);
  @override
  List<Object> get props => [caption];
}

class DeleteStory extends StoryEvent {}
