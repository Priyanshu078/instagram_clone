part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState(this.posts, this.usersList, this.userData, this.tabIndex,
      this.postsIndex, this.usersPosts, this.myData, this.previousPage);
  final List<Post> posts;
  final List<UserData> usersList;
  final UserData userData;
  final UserData myData;
  final int postsIndex;
  final int tabIndex;
  final bool usersPosts;
  final int previousPage;

  @override
  List<Object> get props => [
        posts,
        usersList,
        userData,
        tabIndex,
        postsIndex,
        usersPosts,
        myData,
        previousPage
      ];
}

class SearchInitial extends SearchState {
  const SearchInitial(
      super.posts,
      super.usersList,
      super.userData,
      super.tabIndex,
      super.postsIndex,
      super.usersPosts,
      super.myData,
      super.previousPage);

  @override
  List<Object> get props => [
        posts,
        usersList,
        userData,
        tabIndex,
        postsIndex,
        usersPosts,
        myData,
        previousPage
      ];
}

class PostsFetched extends SearchState {
  const PostsFetched(
      super.posts,
      super.usersList,
      super.userData,
      super.tabIndex,
      super.postsIndex,
      super.usersPosts,
      super.myData,
      super.previousPage);

  @override
  List<Object> get props => [
        posts,
        usersList,
        userData,
        tabIndex,
        postsIndex,
        usersPosts,
        myData,
        previousPage
      ];
}

class UsersSearched extends SearchState {
  const UsersSearched(
      super.posts,
      super.usersList,
      super.userData,
      super.tabIndex,
      super.postsIndex,
      super.usersPosts,
      super.myData,
      super.previousPage);

  @override
  List<Object> get props => [
        posts,
        usersList,
        userData,
        tabIndex,
        postsIndex,
        usersPosts,
        myData,
        previousPage
      ];
}

class UserProfileState extends SearchState {
  const UserProfileState(
      super.posts,
      super.usersList,
      super.userData,
      super.tabIndex,
      super.postsIndex,
      super.usersPosts,
      super.myData,
      super.previousPage);

  @override
  List<Object> get props => [
        posts,
        usersList,
        userData,
        tabIndex,
        postsIndex,
        usersPosts,
        myData,
        previousPage
      ];
}

class TabChangeState extends SearchState {
  const TabChangeState(
      super.posts,
      super.usersList,
      super.userData,
      super.tabIndex,
      super.postsIndex,
      super.usersPosts,
      super.myData,
      super.previousPage);

  @override
  List<Object> get props => [
        posts,
        usersList,
        userData,
        tabIndex,
        postsIndex,
        usersPosts,
        myData,
        previousPage
      ];
}

class PostIndexChangedSearchState extends SearchState {
  const PostIndexChangedSearchState(
      super.posts,
      super.usersList,
      super.userData,
      super.tabIndex,
      super.postsIndex,
      super.usersPosts,
      super.myData,
      super.previousPage);

  @override
  List<Object> get props => [
        posts,
        usersList,
        userData,
        tabIndex,
        postsIndex,
        usersPosts,
        myData,
        previousPage
      ];
}

class LikePostState extends SearchState {
  const LikePostState(
      super.posts,
      super.usersList,
      super.userData,
      super.tabIndex,
      super.postsIndex,
      super.usersPosts,
      super.myData,
      super.previousPage);

  @override
  List<Object> get props => [
        posts,
        usersList,
        userData,
        tabIndex,
        postsIndex,
        usersPosts,
        myData,
        previousPage
      ];
}

class AddedCommentSearchState extends SearchState {
  const AddedCommentSearchState(
      super.posts,
      super.usersList,
      super.userData,
      super.tabIndex,
      super.postsIndex,
      super.usersPosts,
      super.myData,
      super.previousPage);

  @override
  List<Object> get props => [
        posts,
        usersList,
        userData,
        tabIndex,
        postsIndex,
        usersPosts,
        myData,
        previousPage
      ];
}

class DeletedCommentSearchState extends SearchState {
  const DeletedCommentSearchState(
      super.posts,
      super.usersList,
      super.userData,
      super.tabIndex,
      super.postsIndex,
      super.usersPosts,
      super.myData,
      super.previousPage);

  @override
  List<Object> get props => [
        posts,
        usersList,
        userData,
        tabIndex,
        postsIndex,
        usersPosts,
        myData,
        previousPage
      ];
}

class BookmarkedSearchState extends SearchState {
  const BookmarkedSearchState(
      super.posts,
      super.usersList,
      super.userData,
      super.tabIndex,
      super.postsIndex,
      super.usersPosts,
      super.myData,
      super.previousPage);

  @override
  List<Object> get props => [
        posts,
        usersList,
        userData,
        tabIndex,
        postsIndex,
        usersPosts,
        myData,
        previousPage
      ];
}

class DeletedSearchProfilePostState extends SearchState {
  const DeletedSearchProfilePostState(
      super.posts,
      super.usersList,
      super.userData,
      super.tabIndex,
      super.postsIndex,
      super.usersPosts,
      super.myData,
      super.previousPage);

  @override
  List<Object> get props => [
        posts,
        usersList,
        userData,
        tabIndex,
        postsIndex,
        usersPosts,
        myData,
        previousPage
      ];
}

class FollowingSearchState extends SearchState {
  const FollowingSearchState(
      super.posts,
      super.usersList,
      super.userData,
      super.tabIndex,
      super.postsIndex,
      super.usersPosts,
      super.myData,
      super.previousPage);

  @override
  List<Object> get props => [
        posts,
        usersList,
        userData,
        tabIndex,
        postsIndex,
        usersPosts,
        myData,
        previousPage
      ];
}

class FollowedUserSearchState extends SearchState {
  const FollowedUserSearchState(
      super.posts,
      super.usersList,
      super.userData,
      super.tabIndex,
      super.postsIndex,
      super.usersPosts,
      super.myData,
      super.previousPage);

  @override
  List<Object> get props => [
        posts,
        usersList,
        userData,
        tabIndex,
        postsIndex,
        usersPosts,
        myData,
        previousPage
      ];
}

class UnFollowedUserSearchState extends SearchState {
  const UnFollowedUserSearchState(
      super.posts,
      super.usersList,
      super.userData,
      super.tabIndex,
      super.postsIndex,
      super.usersPosts,
      super.myData,
      super.previousPage);

  @override
  List<Object> get props => [
        posts,
        usersList,
        userData,
        tabIndex,
        postsIndex,
        usersPosts,
        myData,
        previousPage
      ];
}

class UnFollowingSearchState extends SearchState {
  const UnFollowingSearchState(
      super.posts,
      super.usersList,
      super.userData,
      super.tabIndex,
      super.postsIndex,
      super.usersPosts,
      super.myData,
      super.previousPage);

  @override
  List<Object> get props => [
        posts,
        usersList,
        userData,
        tabIndex,
        postsIndex,
        usersPosts,
        myData,
        previousPage
      ];
}

class FetchedUserDataSearchState extends SearchState {
  const FetchedUserDataSearchState(
      super.posts,
      super.usersList,
      super.userData,
      super.tabIndex,
      super.postsIndex,
      super.usersPosts,
      super.myData,
      super.previousPage);

  @override
  List<Object> get props => [
        posts,
        usersList,
        userData,
        tabIndex,
        postsIndex,
        usersPosts,
        myData,
        previousPage
      ];
}

class LoadingUserDataSearchState extends SearchState {
  const LoadingUserDataSearchState(
      super.posts,
      super.usersList,
      super.userData,
      super.tabIndex,
      super.postsIndex,
      super.usersPosts,
      super.myData,
      super.previousPage);

  @override
  List<Object> get props => [
        posts,
        usersList,
        userData,
        tabIndex,
        postsIndex,
        usersPosts,
        myData,
        previousPage
      ];
}

class DeletedHighLightSearchState extends SearchState {
  const DeletedHighLightSearchState(
      super.posts,
      super.usersList,
      super.userData,
      super.tabIndex,
      super.postsIndex,
      super.usersPosts,
      super.myData,
      super.previousPage);
  @override
  List<Object> get props => [
        posts,
        usersList,
        userData,
        tabIndex,
        postsIndex,
        usersPosts,
        myData,
        previousPage
      ];
}

class DeletingHighLightSearchState extends SearchState {
  const DeletingHighLightSearchState(
      super.posts,
      super.usersList,
      super.userData,
      super.tabIndex,
      super.postsIndex,
      super.usersPosts,
      super.myData,
      super.previousPage);
  @override
  List<Object> get props => [
        posts,
        usersList,
        userData,
        tabIndex,
        postsIndex,
        usersPosts,
        myData,
        previousPage
      ];
}

class LoadingUserProfileState extends SearchState {
  const LoadingUserProfileState(
      super.posts,
      super.usersList,
      super.userData,
      super.tabIndex,
      super.postsIndex,
      super.usersPosts,
      super.myData,
      super.previousPage);
  @override
  List<Object> get props => [
        posts,
        usersList,
        userData,
        tabIndex,
        postsIndex,
        usersPosts,
        myData,
        previousPage
      ];
}
