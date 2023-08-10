import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/data/comment_data.dart';
import 'package:instagram_clone/data/posts_data.dart';
import 'package:instagram_clone/data/stories.dart';
import 'package:instagram_clone/data/user_data.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:uuid/uuid.dart';
part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(this.pageController)
      : super(
            ProfileLoading(UserData.temp(), 0, 0, false, const [], const [])) {
    on<GetUserDetails>((event, emit) => getUserDetails(event, emit));
    on<EditUserDetails>((event, emit) => editUserDetails(event, emit));
    on<ChangeProfilePhotoEvent>(
        (event, emit) => changeProfilePhotoEvent(event, emit));
    on<LogoutEvent>((event, emit) => logout(event, emit));
    on<ProfilePrivateEvent>((event, emit) => changeProfileStatus(event, emit));
    on<TabChangeEvent>((event, emit) => emit(TabChangedState(
        state.userData,
        event.tabIndex,
        state.postsIndex,
        state.savedPosts,
        state.savedPostsList, const [])));
    on<PostsIndexChangeEvent>((event, emit) => emit(PostIndexChangedState(
        state.userData,
        state.tabIndex,
        event.postIndex,
        false,
        state.savedPostsList, const [])));
    on<LikePostEvent>((event, emit) => likePost(event, emit));
    on<AddProfileComment>((event, emit) => addComment(event, emit));
    on<DeleteProfileComment>((event, emit) => deleteComment(event, emit));
    on<BookmarkProfile>((event, emit) => addBookmark(event, emit));
    on<ShowSavedPosts>((event, emit) => getSavedPosts(event, emit));
    on<DeletePost>((event, emit) => deletePost(event, emit));
    on<FetchPreviousStories>((event, emit) => fetchStories(event, emit));
    on<AddHighlight>((event, emit) => addHighlight(event, emit));
    on<DeleteHighlight>((event, emit) => deleteHighlight(event, emit));
    on<ShareProfileFileEvent>((event, emit) => shareFile(event, emit));
  }

  final PageController pageController;

  Future<void> shareFile(ShareProfileFileEvent event, Emitter emit) async {
    var response = await Dio().get(event.imageUrl,
        options: Options(responseType: ResponseType.bytes));
    Directory dir = await getTemporaryDirectory();
    File file = File('${dir.path}/image.png');
    await file.writeAsBytes(response.data);
    await Share.shareXFiles([XFile(file.path)], text: event.caption);
  }

  Future<void> deleteHighlight(DeleteHighlight event, Emitter emit) async {
    emit(DeletingHighLight(state.userData, state.tabIndex, state.postsIndex,
        state.savedPosts, state.savedPostsList, state.previousStories));
    var sharedPreferences = await SharedPreferences.getInstance();
    String? userId = sharedPreferences.getString("userId");
    List<Story> highlights = state.userData.stories;
    highlights.removeAt(event.index);
    UserData userData = state.userData.copyWith(stories: highlights);
    await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .update(userData.toJson());
    emit(HighlightDeleted(userData, state.tabIndex, state.postsIndex,
        state.savedPosts, state.savedPostsList, state.previousStories));
  }

  Future<void> addHighlight(AddHighlight event, Emitter emit) async {
    emit(AddingHighLight(state.userData, state.tabIndex, state.postsIndex,
        state.savedPosts, state.savedPostsList, state.previousStories));
    var sharedPreferences = await SharedPreferences.getInstance();
    String? userId = sharedPreferences.getString("userId");
    List<Story> highlights = state.userData.stories;
    highlights.add(event.story);
    UserData userData = state.userData.copyWith(stories: highlights);
    await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .update(userData.toJson());
    emit(HighLightAddedState(userData, state.tabIndex, state.postsIndex,
        state.savedPosts, state.savedPostsList, state.previousStories));
  }

  Future<void> fetchStories(FetchPreviousStories event, Emitter emit) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    String? userId = sharedPreferences.getString("userId");
    var docSnapshot = await FirebaseFirestore.instance
        .collection("stories")
        .doc(userId)
        .get();
    var docData = docSnapshot.data()!;
    List<Story> previousStories = [];
    for (var story in docData['previous_stories']) {
      previousStories.add(Story.fromJson(story));
    }
    emit(FetchedPreviousStories(
        state.userData,
        state.tabIndex,
        state.postsIndex,
        state.savedPosts,
        state.savedPostsList,
        previousStories));
  }

  Future<void> deletePost(DeletePost event, Emitter emit) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    String? userId = sharedPreferences.getString("userId");
    List<Post> posts = List.from(state.userData.posts);
    posts.removeAt(event.index);
    UserData userData = state.userData.copyWith(posts: posts);
    await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .update(userData.toJson());
    emit(DeletedPostState(userData, state.tabIndex, state.postsIndex,
        state.savedPosts, state.savedPostsList, const []));
  }

  Future<void> getSavedPosts(ShowSavedPosts event, Emitter emit) async {
    emit(ProfileLoading(state.userData, state.tabIndex, state.postsIndex, true,
        state.savedPostsList, const []));
    var firestoreCollectionRef = FirebaseFirestore.instance.collection("users");
    List bookmarkedPostsList = state.userData.bookmarks;
    List<Post> savedPostsList = [];
    var snapshot = await firestoreCollectionRef.get();
    var docsList = snapshot.docs;
    for (int i = 0; i < docsList.length; i++) {
      UserData userData = UserData.fromJson(docsList[i].data());
      List<Post> posts = userData.posts;
      for (int j = 0; j < posts.length; j++) {
        if (bookmarkedPostsList.contains(posts[j].id)) {
          savedPostsList.add(posts[j]);
        }
      }
    }
    savedPostsList.shuffle();
    emit(SavedPostsState(state.userData, state.tabIndex, state.postsIndex, true,
        savedPostsList, const []));
  }

  Future<void> addBookmark(BookmarkProfile event, Emitter emit) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    String myUserId = sharedPreferences.getString("userId")!;
    List bookmarks = List.from(state.userData.bookmarks);
    String postId = state.savedPosts
        ? state.savedPostsList[event.postIndex].id
        : state.userData.posts[event.postIndex].id;
    List<Post> savedPostsList = [];
    if (bookmarks.contains(postId)) {
      bookmarks.remove(postId);
      if (state.savedPosts) {
        savedPostsList = state.savedPostsList;
        savedPostsList.removeAt(event.postIndex);
      }
    } else {
      bookmarks.add(postId);
    }
    UserData userData = state.userData.copyWith(bookmarks: bookmarks);
    await FirebaseFirestore.instance
        .collection("users")
        .doc(myUserId)
        .update(userData.toJson());
    emit(BookmarkedProfileState(
        userData,
        state.tabIndex,
        state.postsIndex,
        state.savedPosts,
        state.savedPosts ? savedPostsList : state.savedPostsList, const []));
  }

  Future<void> addComment(AddProfileComment event, Emitter emit) async {
    List<Comments> existingcomments = List.from(event.comments);
    String userId = state.userData.id;
    String profilePhotoUrl = state.userData.profilePhotoUrl;
    String username = state.userData.username;
    String id = const Uuid().v4();
    Comments newComment =
        Comments(event.comment, profilePhotoUrl, username, userId, id);
    existingcomments.add(newComment);
    if (state.savedPosts) {
      List<Post> posts = List.from(state.savedPostsList);
      posts[event.postIndex] =
          posts[event.postIndex].copyWith(comments: existingcomments);
      String userId = posts[event.postIndex].userId;
      var firestoreCollectionRef =
          FirebaseFirestore.instance.collection("users");
      var docSnapshot = await firestoreCollectionRef.doc(userId).get();
      UserData userData = UserData.fromJson(docSnapshot.data()!);
      List<Post> userPosts = userData.posts;
      for (int i = 0; i < userPosts.length; i++) {
        if (userPosts[i].id == posts[event.postIndex].id) {
          userPosts[i] = userPosts[i].copyWith(comments: existingcomments);
        }
      }
      UserData data = userData.copyWith(posts: userPosts);
      await firestoreCollectionRef.doc(userId).update(data.toJson());
      emit(CommentAddedProfileState(state.userData, state.tabIndex,
          state.postsIndex, state.savedPosts, posts, const []));
    } else {
      List<Post> posts = List.from(state.userData.posts);
      posts[event.postIndex] = state.userData.posts[event.postIndex]
          .copyWith(comments: existingcomments);
      UserData userData = state.userData.copyWith(posts: posts);
      await FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .update(userData.toJson());
      emit(CommentAddedProfileState(userData, state.tabIndex, state.postsIndex,
          state.savedPosts, state.savedPostsList, const []));
    }
  }

  Future<void> deleteComment(DeleteProfileComment event, Emitter emit) async {
    List<Comments> exisitingComments = state.savedPosts
        ? List.from(state.savedPostsList[event.postIndex].comments)
        : List.from(state.userData.posts[event.postIndex].comments);
    exisitingComments.removeAt(event.commentIndex);
    if (state.savedPosts) {
      List<Post> savedPostsList = List.from(state.savedPostsList);
      savedPostsList[event.postIndex] =
          savedPostsList[event.postIndex].copyWith(comments: exisitingComments);
      String userId = savedPostsList[event.postIndex].userId;
      var firestoreCollectionRef =
          FirebaseFirestore.instance.collection("users");
      var docSnapshot = await firestoreCollectionRef.doc(userId).get();
      UserData userData = UserData.fromJson(docSnapshot.data()!);
      List<Post> posts = userData.posts;
      for (int i = 0; i < posts.length; i++) {
        if (posts[i].id == savedPostsList[event.postIndex].id) {
          posts[i] = posts[i].copyWith(comments: exisitingComments);
        }
      }
      UserData updatedUserData = userData.copyWith(posts: posts);
      await firestoreCollectionRef.doc(userId).update(updatedUserData.toJson());
      emit(DeletedCommentProfileState(state.userData, state.tabIndex,
          state.postsIndex, state.savedPosts, savedPostsList, const []));
    } else {
      List<Post> posts = state.userData.posts;
      posts[event.postIndex] = state.userData.posts[event.postIndex]
          .copyWith(comments: exisitingComments);
      UserData userData = state.userData.copyWith(posts: posts);
      String userId = state.userData.id;
      await FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .update(userData.toJson());
      emit(DeletedCommentProfileState(userData, state.tabIndex,
          state.postsIndex, state.savedPosts, state.savedPostsList, const []));
    }
  }

  Future<void> likePost(LikePostEvent event, Emitter emit) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? myUserId = sharedPreferences.getString("userId");
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    final collectionRef = firebaseFirestore.collection("users");
    if (state.savedPosts) {
      List<Post> savedPostsList = List.from(state.savedPostsList);
      List likes = savedPostsList[event.index].likes;
      if (likes.contains(myUserId)) {
        likes.remove(myUserId);
      } else {
        likes.add(myUserId);
      }
      savedPostsList[event.index] =
          savedPostsList[event.index].copyWith(likes: likes);
      String userId = savedPostsList[event.index].userId;
      var docSnapshot = await collectionRef.doc(userId).get();
      var docData = docSnapshot.data()!;
      UserData userData = UserData.fromJson(docData);
      List<Post> posts = userData.posts;
      for (int i = 0; i < posts.length; i++) {
        if (savedPostsList[event.index].id == posts[i].id) {
          posts[i].likes = likes;
        }
      }
      UserData updatedUserData = userData.copyWith(posts: posts);
      await collectionRef.doc(userId).update(updatedUserData.toJson());
      emit(PostLikedProfileState(state.userData, state.tabIndex,
          state.postsIndex, state.savedPosts, savedPostsList, const []));
    } else {
      var documentData = collectionRef.doc(myUserId);
      List<Post> posts = List.from(state.userData.posts);
      List likes = posts[event.index].likes;
      if (likes.contains(myUserId)) {
        likes.remove(myUserId);
      } else {
        likes.add(myUserId);
      }
      posts[event.index] =
          state.userData.posts[event.index].copyWith(likes: likes);
      UserData userData = state.userData.copyWith(posts: posts);
      var value = await documentData.get();
      var data = value.data()!;
      data["posts"][event.index]["likes"] = likes;
      await documentData.update(data);
      emit(PostLikedProfileState(userData, state.tabIndex, state.postsIndex,
          state.savedPosts, state.savedPostsList, const []));
    }
  }

  Future<void> changeProfileStatus(
      ProfilePrivateEvent event, Emitter emit) async {
    var firestoreCollectionRef = FirebaseFirestore.instance.collection('users');
    await firestoreCollectionRef
        .doc(event.userData.id)
        .update({"private": event.userData.private});
    emit(ProfilePrivateState(event.userData, state.tabIndex, state.postsIndex,
        state.savedPosts, state.savedPostsList, const []));
  }

  Future<void> logout(LogoutEvent event, Emitter emit) async {
    var sharedPrefernces = await SharedPreferences.getInstance();
    await sharedPrefernces.clear();
    emit(LogoutDoneState(state.userData, state.tabIndex, state.postsIndex,
        state.savedPosts, state.savedPostsList, const []));
  }

  Future<void> getUserDetails(GetUserDetails event, Emitter emit) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    var userId = sharedPreferences.getString("userId");
    var collectionRef = FirebaseFirestore.instance.collection("users");
    Query<Map<String, dynamic>> queriedData =
        collectionRef.where("id", isEqualTo: userId);
    var snapshotData = await queriedData.get();
    UserData userData = UserData.fromJson(snapshotData.docs.first.data());
    if (kDebugMode) {
      print(userData);
    }
    emit(UserDataFetched(userData, state.tabIndex, state.postsIndex,
        state.savedPosts, state.savedPostsList, const []));
  }

  Future<void> editUserDetails(EditUserDetails event, Emitter emit) async {
    var collectionRef = FirebaseFirestore.instance.collection("users");
    await collectionRef.doc(event.userData.id).update({
      "name": event.userData.name,
      "username": event.userData.username,
      "tagline": event.userData.tagline,
      "bio": event.userData.bio,
      "profilePhotoUrl": event.userData.profilePhotoUrl,
    });
    emit(UserDataEdited(event.userData, state.tabIndex, state.postsIndex,
        state.savedPosts, state.savedPostsList, const []));
  }

  Future<void> changeProfilePhotoEvent(
      ChangeProfilePhotoEvent event, Emitter emit) async {
    emit(ProfilePhotoLoading(event.userData.copyWith(), state.tabIndex,
        state.postsIndex, state.savedPosts, state.savedPostsList, const []));
    var profileImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    var storageRef = FirebaseStorage.instance.ref();
    Reference imagesRef = storageRef.child(event.userData.id);
    const fileName = "profilePhoto.jpg";
    final profilePhotoRef = imagesRef.child(fileName);
    // final path = profilePhotoRef.fullPath;
    File image = File(profileImage!.path);
    await profilePhotoRef.putFile(image);
    final imagePath = await profilePhotoRef.getDownloadURL();
    await FirebaseFirestore.instance
        .collection("users")
        .doc(event.userData.id)
        .update({"profilePhotoUrl": imagePath});
    UserData userData = event.userData.copyWith(profilePhotoUrl: imagePath);
    emit(ProfilePhotoEdited(userData, state.tabIndex, state.postsIndex,
        state.savedPosts, state.savedPostsList, const []));
  }
}
