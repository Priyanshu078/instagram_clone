part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  final UserData userData;
  final int tabIndex;
  final int postsIndex;
  final bool savedPosts;
  const ProfileState(
      this.userData, this.tabIndex, this.postsIndex, this.savedPosts);

  @override
  List<Object> get props => [userData, tabIndex, postsIndex, savedPosts];
}

class ProfileLoading extends ProfileState {
  const ProfileLoading(
      super.userData, super.tabIndex, super.postsIndex, super.savedPosts);
  @override
  List<Object> get props => [userData, tabIndex, postsIndex, savedPosts];
}

class UserDataFetched extends ProfileState {
  const UserDataFetched(
      super.userData, super.tabIndex, super.postsIndex, super.savedPosts);
  @override
  List<Object> get props => [userData, tabIndex, postsIndex, savedPosts];
}

class UserDataEdited extends ProfileState {
  const UserDataEdited(
      super.userData, super.tabIndex, super.postsIndex, super.savedPosts);
  @override
  List<Object> get props => [userData, tabIndex, postsIndex, savedPosts];
}

class ProfilePhotoEdited extends ProfileState {
  const ProfilePhotoEdited(
      super.userData, super.tabIndex, super.postsIndex, super.savedPosts);
  @override
  List<Object> get props => [userData, tabIndex, postsIndex, savedPosts];
}

class ProfilePhotoLoading extends ProfileState {
  const ProfilePhotoLoading(
      super.userData, super.tabIndex, super.postsIndex, super.savedPosts);
  @override
  List<Object> get props => [userData, tabIndex, postsIndex, savedPosts];
}

class LogoutDoneState extends ProfileState {
  const LogoutDoneState(
      super.userData, super.tabIndex, super.postsIndex, super.savedPosts);
  @override
  List<Object> get props => [userData, tabIndex, postsIndex, savedPosts];
}

class ProfilePrivateState extends ProfileState {
  const ProfilePrivateState(
      super.userData, super.tabIndex, super.postsIndex, super.savedPosts);

  @override
  List<Object> get props => [userData, tabIndex, postsIndex, savedPosts];
}

class TabChangedState extends ProfileState {
  const TabChangedState(
      super.userData, super.tabIndex, super.postsIndex, super.savedPosts);

  @override
  List<Object> get props => [userData, tabIndex, postsIndex, savedPosts];
}

class PostIndexChangedState extends ProfileState {
  const PostIndexChangedState(
      super.userData, super.tabIndex, super.postsIndex, super.savedPosts);

  @override
  List<Object> get props => [userData, tabIndex, postsIndex, savedPosts];
}

class PostLikedState extends ProfileState {
  const PostLikedState(
      super.userData, super.tabIndex, super.postsIndex, super.savedPosts);

  @override
  List<Object> get props => [userData, tabIndex, postsIndex, savedPosts];
}

class CommentAddedProfileState extends ProfileState {
  const CommentAddedProfileState(
      super.userData, super.tabIndex, super.postsIndex, super.savedPosts);

  @override
  List<Object> get props => [userData, tabIndex, postsIndex, savedPosts];
}

class DeletedCommentProfileState extends ProfileState {
  const DeletedCommentProfileState(
      super.userData, super.tabIndex, super.postsIndex, super.savedPosts);

  @override
  List<Object> get props => [userData, tabIndex, postsIndex, savedPosts];
}

class BookmarkedState extends ProfileState {
  const BookmarkedState(
      super.userData, super.tabIndex, super.postsIndex, super.savedPosts);
  @override
  List<Object> get props => [userData, tabIndex, postsIndex, savedPosts];
}

class SavedPostsState extends ProfileState {
  const SavedPostsState(
      super.userData, super.tabIndex, super.postsIndex, super.savedPosts);
  @override
  List<Object> get props => [userData, tabIndex, postsIndex, savedPosts];
}
