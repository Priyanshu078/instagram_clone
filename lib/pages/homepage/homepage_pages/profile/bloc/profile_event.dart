part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class GetUserDetails extends ProfileEvent {}

class EditUserDetails extends ProfileEvent {
  final UserData userData;
  const EditUserDetails(this.userData);

  @override
  List<Object> get props => [userData];
}

class ChangeProfilePhotoEvent extends ProfileEvent {
  final UserData userData;
  const ChangeProfilePhotoEvent(this.userData);

  @override
  List<Object> get props => [userData];
}

class LogoutEvent extends ProfileEvent {}

class ProfilePrivateEvent extends ProfileEvent {
  final UserData userData;
  const ProfilePrivateEvent(this.userData);

  @override
  List<Object> get props => [userData];
}

class TabChangeEvent extends ProfileEvent {
  final int tabIndex;
  const TabChangeEvent(this.tabIndex);

  @override
  List<Object> get props => [tabIndex];
}

class PostsIndexChangeEvent extends ProfileEvent {
  final int postIndex;
  const PostsIndexChangeEvent(this.postIndex);

  @override
  List<Object> get props => [postIndex];
}

class LikePostEvent extends ProfileEvent {
  final int index;
  const LikePostEvent(this.index);

  @override
  List<Object> get props => [index];
}

class AddProfileComment extends ProfileEvent {
  final List<Comments> comments;
  final int postIndex;
  final String comment;
  const AddProfileComment(this.comments, this.postIndex, this.comment);

  @override
  List<Object> get props => [comments, postIndex, comment];
}

class DeleteProfileComment extends ProfileEvent {
  final int postIndex;
  final int commentIndex;
  const DeleteProfileComment(this.postIndex, this.commentIndex);
  @override
  List<Object> get props => [postIndex, commentIndex];
}

class BookmarkProfile extends ProfileEvent {
  final int postIndex;
  const BookmarkProfile(this.postIndex);
  @override
  List<Object> get props => [postIndex];
}

class ShowSavedPosts extends ProfileEvent {}

class DeletePost extends ProfileEvent {
  final int index;
  const DeletePost(this.index);

  @override
  List<Object> get props => [index];
}

class FetchPreviousStories extends ProfileEvent {}

class AddHighlight extends ProfileEvent {
  final Story story;
  const AddHighlight(this.story);

  @override
  List<Object> get props => [story];
}

class DeleteHighlight extends ProfileEvent {
  final int index;
  const DeleteHighlight(this.index);

  @override
  List<Object> get props => [index];
}

class ShareProfileFileEvent extends ProfileEvent {
  final String imageUrl;
  final String caption;

  const ShareProfileFileEvent({required this.imageUrl, required this.caption});
  @override
  List<Object> get props => [imageUrl, caption];
}
