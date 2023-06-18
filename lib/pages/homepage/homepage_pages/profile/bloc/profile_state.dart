part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  final UserData userData;
  final int tabIndex;
  final int postsIndex;
  const ProfileState(this.userData, this.tabIndex, this.postsIndex);

  @override
  List<Object> get props => [userData, tabIndex, postsIndex];
}

class ProfileLoading extends ProfileState {
  const ProfileLoading(super.userData, super.tabIndex, super.postsIndex);
  @override
  List<Object> get props => [userData, tabIndex, postsIndex];
}

class UserDataFetched extends ProfileState {
  const UserDataFetched(super.userData, super.tabIndex, super.postsIndex);
  @override
  List<Object> get props => [userData, tabIndex, postsIndex];
}

class UserDataEdited extends ProfileState {
  const UserDataEdited(super.userData, super.tabIndex, super.postsIndex);
  @override
  List<Object> get props => [userData, tabIndex, postsIndex];
}

class ProfilePhotoEdited extends ProfileState {
  const ProfilePhotoEdited(super.userData, super.tabIndex, super.postsIndex);
  @override
  List<Object> get props => [userData, tabIndex, postsIndex];
}

class ProfilePhotoLoading extends ProfileState {
  const ProfilePhotoLoading(super.userData, super.tabIndex, super.postsIndex);
  @override
  List<Object> get props => [userData, tabIndex, postsIndex];
}

class LogoutDoneState extends ProfileState {
  const LogoutDoneState(super.userData, super.tabIndex, super.postsIndex);
  @override
  List<Object> get props => [userData, tabIndex, postsIndex];
}

class ProfilePrivateState extends ProfileState {
  const ProfilePrivateState(super.userData, super.tabIndex, super.postsIndex);

  @override
  List<Object> get props => [userData, tabIndex, postsIndex];
}

class TabChangedState extends ProfileState {
  const TabChangedState(super.userData, super.tabIndex, super.postsIndex);

  @override
  List<Object> get props => [userData, tabIndex, postsIndex];
}

class PostIndexChangedState extends ProfileState {
  const PostIndexChangedState(super.userData, super.tabIndex, super.postsIndex);

  @override
  List<Object> get props => [userData, tabIndex, postsIndex];
}

class PostLikedState extends ProfileState {
  const PostLikedState(super.userData, super.tabIndex, super.postsIndex);

  @override
  List<Object> get props => [userData, tabIndex, postsIndex];
}

class CommentAddedProfileState extends ProfileState {
  const CommentAddedProfileState(
      super.userData, super.tabIndex, super.postsIndex);

  @override
  List<Object> get props => [userData, tabIndex, postsIndex];
}

class DeletedCommentProfileState extends ProfileState {
  const DeletedCommentProfileState(
      super.userData, super.tabIndex, super.postsIndex);

  @override
  List<Object> get props => [userData, tabIndex, postsIndex];
}
