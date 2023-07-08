part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  final UserData userData;
  final int tabIndex;
  final int postsIndex;
  final bool savedPosts;
  final List<Post> savedPostsList;
  final List<Story> previousStories;
  const ProfileState(this.userData, this.tabIndex, this.postsIndex,
      this.savedPosts, this.savedPostsList, this.previousStories);

  @override
  List<Object> get props => [
        userData,
        tabIndex,
        postsIndex,
        savedPosts,
        savedPostsList,
        previousStories
      ];
}

class ProfileLoading extends ProfileState {
  const ProfileLoading(super.userData, super.tabIndex, super.postsIndex,
      super.savedPosts, super.savedPostsList, super.previousStories);
  @override
  List<Object> get props => [
        userData,
        tabIndex,
        postsIndex,
        savedPosts,
        savedPostsList,
        previousStories
      ];
}

class UserDataFetched extends ProfileState {
  const UserDataFetched(super.userData, super.tabIndex, super.postsIndex,
      super.savedPosts, super.savedPostsList, super.previousStories);
  @override
  List<Object> get props => [
        userData,
        tabIndex,
        postsIndex,
        savedPosts,
        savedPostsList,
        previousStories
      ];
}

class UserDataEdited extends ProfileState {
  const UserDataEdited(super.userData, super.tabIndex, super.postsIndex,
      super.savedPosts, super.savedPostsList, super.previousStories);
  @override
  List<Object> get props => [
        userData,
        tabIndex,
        postsIndex,
        savedPosts,
        savedPostsList,
        previousStories
      ];
}

class ProfilePhotoEdited extends ProfileState {
  const ProfilePhotoEdited(super.userData, super.tabIndex, super.postsIndex,
      super.savedPosts, super.savedPostsList, super.previousStories);
  @override
  List<Object> get props => [
        userData,
        tabIndex,
        postsIndex,
        savedPosts,
        savedPostsList,
        previousStories
      ];
}

class ProfilePhotoLoading extends ProfileState {
  const ProfilePhotoLoading(super.userData, super.tabIndex, super.postsIndex,
      super.savedPosts, super.savedPostsList, super.previousStories);
  @override
  List<Object> get props => [
        userData,
        tabIndex,
        postsIndex,
        savedPosts,
        savedPostsList,
        previousStories
      ];
}

class LogoutDoneState extends ProfileState {
  const LogoutDoneState(super.userData, super.tabIndex, super.postsIndex,
      super.savedPosts, super.savedPostsList, super.previousStories);
  @override
  List<Object> get props => [
        userData,
        tabIndex,
        postsIndex,
        savedPosts,
        savedPostsList,
        previousStories
      ];
}

class ProfilePrivateState extends ProfileState {
  const ProfilePrivateState(super.userData, super.tabIndex, super.postsIndex,
      super.savedPosts, super.savedPostsList, super.previousStories);

  @override
  List<Object> get props => [
        userData,
        tabIndex,
        postsIndex,
        savedPosts,
        savedPostsList,
        previousStories
      ];
}

class TabChangedState extends ProfileState {
  const TabChangedState(super.userData, super.tabIndex, super.postsIndex,
      super.savedPosts, super.savedPostsList, super.previousStories);

  @override
  List<Object> get props => [
        userData,
        tabIndex,
        postsIndex,
        savedPosts,
        savedPostsList,
        previousStories
      ];
}

class PostIndexChangedState extends ProfileState {
  const PostIndexChangedState(super.userData, super.tabIndex, super.postsIndex,
      super.savedPosts, super.savedPostsList, super.previousStories);

  @override
  List<Object> get props => [
        userData,
        tabIndex,
        postsIndex,
        savedPosts,
        savedPostsList,
        previousStories
      ];
}

class PostLikedProfileState extends ProfileState {
  const PostLikedProfileState(super.userData, super.tabIndex, super.postsIndex,
      super.savedPosts, super.savedPostsList, super.previousStories);

  @override
  List<Object> get props => [
        userData,
        tabIndex,
        postsIndex,
        savedPosts,
        savedPostsList,
        previousStories
      ];
}

class CommentAddedProfileState extends ProfileState {
  const CommentAddedProfileState(
      super.userData,
      super.tabIndex,
      super.postsIndex,
      super.savedPosts,
      super.savedPostsList,
      super.previousStories);

  @override
  List<Object> get props => [
        userData,
        tabIndex,
        postsIndex,
        savedPosts,
        savedPostsList,
        previousStories
      ];
}

class DeletedCommentProfileState extends ProfileState {
  const DeletedCommentProfileState(
      super.userData,
      super.tabIndex,
      super.postsIndex,
      super.savedPosts,
      super.savedPostsList,
      super.previousStories);

  @override
  List<Object> get props => [
        userData,
        tabIndex,
        postsIndex,
        savedPosts,
        savedPostsList,
        previousStories
      ];
}

class BookmarkedProfileState extends ProfileState {
  const BookmarkedProfileState(super.userData, super.tabIndex, super.postsIndex,
      super.savedPosts, super.savedPostsList, super.previousStories);
  @override
  List<Object> get props => [
        userData,
        tabIndex,
        postsIndex,
        savedPosts,
        savedPostsList,
        previousStories
      ];
}

class SavedPostsState extends ProfileState {
  const SavedPostsState(super.userData, super.tabIndex, super.postsIndex,
      super.savedPosts, super.savedPostsList, super.previousStories);
  @override
  List<Object> get props => [
        userData,
        tabIndex,
        postsIndex,
        savedPosts,
        savedPostsList,
        previousStories
      ];
}

class DeletedPostState extends ProfileState {
  const DeletedPostState(super.userData, super.tabIndex, super.postsIndex,
      super.savedPosts, super.savedPostsList, super.previousStories);

  @override
  List<Object> get props => [
        userData,
        tabIndex,
        postsIndex,
        savedPosts,
        savedPostsList,
        previousStories
      ];
}

class FetchedPreviousStories extends ProfileState {
  const FetchedPreviousStories(super.userData, super.tabIndex, super.postsIndex,
      super.savedPosts, super.savedPostsList, super.previousStories);
  @override
  List<Object> get props => [
        userData,
        tabIndex,
        postsIndex,
        savedPosts,
        savedPostsList,
        previousStories
      ];
}

class HighLightAddedState extends ProfileState {
  const HighLightAddedState(super.userData, super.tabIndex, super.postsIndex,
      super.savedPosts, super.savedPostsList, super.previousStories);
  @override
  List<Object> get props => [
        userData,
        tabIndex,
        postsIndex,
        savedPosts,
        savedPostsList,
        previousStories
      ];
}

class AddingHighLight extends ProfileState {
  const AddingHighLight(super.userData, super.tabIndex, super.postsIndex,
      super.savedPosts, super.savedPostsList, super.previousStories);
  @override
  List<Object> get props => [
        userData,
        tabIndex,
        postsIndex,
        savedPosts,
        savedPostsList,
        previousStories
      ];
}

class DeletingHighLight extends ProfileState {
  const DeletingHighLight(super.userData, super.tabIndex, super.postsIndex,
      super.savedPosts, super.savedPostsList, super.previousStories);
  @override
  List<Object> get props => [
        userData,
        tabIndex,
        postsIndex,
        savedPosts,
        savedPostsList,
        previousStories
      ];
}

class HighlightDeleted extends ProfileState {
  const HighlightDeleted(super.userData, super.tabIndex, super.postsIndex,
      super.savedPosts, super.savedPostsList, super.previousStories);
  @override
  List<Object> get props => [
        userData,
        tabIndex,
        postsIndex,
        savedPosts,
        savedPostsList,
        previousStories
      ];
}
