import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:instagram_clone/data/comment_data.dart';
import 'package:instagram_clone/data/notification_data.dart';
import 'package:instagram_clone/data/posts_data.dart';
import 'package:instagram_clone/data/stories.dart';
import 'package:instagram_clone/data/user_data.dart';
import 'package:instagram_clone/utility/notification_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final PageController pageController;
  final FocusNode focusNode;
  final TextEditingController searchController;

  SearchBloc(this.pageController, this.focusNode, this.searchController)
      : super(SearchInitial(const <Post>[], const <UserData>[], UserData.temp(),
            0, 0, true, UserData.temp(), 1)) {
    on<GetPosts>((event, emit) => getPosts(event, emit));
    on<SearchUsers>((event, emit) => searchUsers(event, emit));
    on<UserProfileEvent>((event, emit) => getUserProfileData(event, emit));
    on<UserProfileBackEvent>((event, emit) => emit(UsersSearched(
        state.posts,
        state.usersList,
        state.userData,
        state.tabIndex,
        state.postsIndex,
        state.usersPosts,
        state.myData,
        0)));
    on<TabChangeEvent>((event, emit) => emit(TabChangeState(
        state.posts,
        state.usersList,
        state.userData,
        event.tabIndex,
        state.postsIndex,
        state.usersPosts,
        state.myData,
        state.previousPage)));
    on<PostsIndexChangeEvent>((event, emit) => emit(PostIndexChangedSearchState(
          state.posts,
          state.usersList,
          state.userData,
          state.tabIndex,
          event.postIndex,
          event.usersPosts,
          state.myData,
          state.previousPage,
        )));
    on<SearchLikePostEvent>((event, emit) => likePost(event, emit));
    on<AddSearchComment>((event, emit) => addComment(event, emit));
    on<DeleteSearchComment>((event, emit) => deleteComment(event, emit));
    on<BookmarkSearch>((event, emit) => addBookmark(event, emit));
    on<DeleteSearchProfilePost>((event, emit) => deletePost(event, emit));
    on<FollowSearchEvent>((event, emit) => follow(event, emit));
    on<UnFollowSearchEvent>((event, emit) => unfollow(event, emit));
    on<FetchUserDataInSearch>((event, emit) => fetchUserData(event, emit));
    on<ShareSearchFileEvent>((event, emit) => shareFile(event, emit));
    on<DeleteSearchProfileHighlight>(
        (event, emit) => deleteSearchProfileHightlight(event, emit));
  }

  Future<void> getUserProfileData(UserProfileEvent event, Emitter emit) async {
    emit(LoadingUserProfileState(state.posts, state.usersList, state.userData,
        state.tabIndex, state.postsIndex, state.usersPosts, state.myData, 1));
    String userId = event.userData.id;
    var snapshot =
        await FirebaseFirestore.instance.collection("users").doc(userId).get();
    UserData userData = UserData.fromJson(snapshot.data()!);
    emit(UserProfileState(state.posts, state.usersList, userData,
        state.tabIndex, state.postsIndex, state.usersPosts, state.myData, 1));
  }

  Future<void> deleteSearchProfileHightlight(
      DeleteSearchProfileHighlight event, Emitter emit) async {
    emit(DeletingHighLightSearchState(
        state.posts,
        state.usersList,
        state.userData,
        state.tabIndex,
        state.postsIndex,
        state.usersPosts,
        state.myData,
        state.previousPage));
    var sharedPreferences = await SharedPreferences.getInstance();
    String? userId = sharedPreferences.getString("userId");
    List<Story> hightlights = List.from(state.myData.stories);
    hightlights.removeAt(event.index);
    UserData userData = state.userData.copyWith(stories: hightlights);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .update(userData.toJson());
    emit(DeletedHighLightSearchState(
        state.posts,
        state.usersList,
        userData,
        state.tabIndex,
        state.postsIndex,
        state.usersPosts,
        userData,
        state.previousPage));
  }

  Future<void> shareFile(ShareSearchFileEvent event, Emitter emit) async {
    var response = await Dio().get(event.imageUrl,
        options: Options(responseType: ResponseType.bytes));
    Directory dir = await getTemporaryDirectory();
    File file = File('${dir.path}/image.png');
    await file.writeAsBytes(response.data);
    await Share.shareXFiles([XFile(file.path)], text: event.caption);
  }

  Future<void> fetchUserData(FetchUserDataInSearch event, Emitter emit) async {
    emit(LoadingUserDataSearchState(
        state.posts,
        state.usersList,
        state.userData,
        state.tabIndex,
        state.postsIndex,
        state.usersPosts,
        state.myData,
        2));
    String userId = event.userId;
    var docSnapshot =
        await FirebaseFirestore.instance.collection("users").doc(userId).get();
    UserData userData = UserData.fromJson(docSnapshot.data()!);
    emit(FetchedUserDataSearchState(
        state.posts,
        state.usersList,
        userData,
        state.tabIndex,
        state.postsIndex,
        state.usersPosts,
        state.myData,
        state.previousPage));
  }

  Future<void> follow(FollowSearchEvent event, Emitter emit) async {
    emit(FollowingSearchState(
        state.posts,
        state.usersList,
        state.userData,
        state.tabIndex,
        state.postsIndex,
        state.usersPosts,
        state.myData,
        state.previousPage));
    var sharedPreferences = await SharedPreferences.getInstance();
    String? myUserId = sharedPreferences.getString("userId");
    String? username = sharedPreferences.getString("username");
    String? userProfilePhotoUrl =
        sharedPreferences.getString("profilePhotoUrl");
    var collectionRef = FirebaseFirestore.instance.collection("users");
    if (event.fromProfile) {
      List followers = state.userData.followers;
      followers.add(myUserId);
      UserData userData = state.userData.copyWith(followers: followers);
      await collectionRef.doc(userData.id).update(userData.toJson());
      List following = state.myData.following;
      following.add(userData.id);
      UserData myData = state.myData.copyWith(following: following);
      await collectionRef.doc(myUserId).update(myData.toJson());
      emit(FollowedUserSearchState(
          state.posts,
          state.usersList,
          userData,
          state.tabIndex,
          state.postsIndex,
          state.usersPosts,
          myData,
          state.previousPage));
    } else {
      String userId = state.posts[event.index!].userId;
      var docSnapshot = await collectionRef.doc(userId).get();
      UserData userData = UserData.fromJson(docSnapshot.data()!);
      List followers = userData.followers;
      followers.add(myUserId);
      await collectionRef
          .doc(userId)
          .update(userData.copyWith(followers: followers).toJson());
      List following = state.myData.following;
      following.add(userId);
      UserData myData = state.myData.copyWith(following: following);
      await collectionRef.doc(myUserId).update(myData.toJson());
      emit(FollowedUserSearchState(
          state.posts,
          state.usersList,
          state.userData,
          state.tabIndex,
          state.postsIndex,
          state.usersPosts,
          myData,
          state.previousPage));
    }
    String title = "New Follower";
    String imageUrl = "";
    String body = "$username follows you";
    var userData = await collectionRef
        .doc(event.fromProfile
            ? state.userData.id
            : state.posts[event.index!].userId)
        .get();
    List receiverFcmToken =
        List.generate(1, (index) => userData.data()!['fcmToken']);
    await NotificationService()
        .sendNotification(title, imageUrl, body, receiverFcmToken, false);
    var notificationCollectionRef =
        FirebaseFirestore.instance.collection("notifications");
    var notificationData =
        await notificationCollectionRef.doc(userData.data()!['id']).get();
    var notifications = [];
    if (notificationData.data() == null) {
      await notificationCollectionRef
          .doc(userData.data()!['id'])
          .set({"notifications": [], "new_notifications": false});
    } else {
      notifications = notificationData.data()!['notifications'];
    }
    NotificationData newNotification = NotificationData(
      const Uuid().v4(),
      username!,
      body,
      imageUrl,
      userProfilePhotoUrl!,
      DateTime.now().toString(),
      myUserId!,
    );
    notifications.add(newNotification.toJson());
    await notificationCollectionRef
        .doc(userData.data()!['id'])
        .update({"new_notifications": true, "notifications": notifications});
  }

  Future<void> unfollow(UnFollowSearchEvent event, Emitter emit) async {
    emit(UnFollowingSearchState(
        state.posts,
        state.usersList,
        state.userData,
        state.tabIndex,
        state.postsIndex,
        state.usersPosts,
        state.myData,
        state.previousPage));
    var sharedPreferences = await SharedPreferences.getInstance();
    String? myUserId = sharedPreferences.getString("userId");
    var collectionRef = FirebaseFirestore.instance.collection("users");
    if (event.fromProfile) {
      List followers = state.userData.followers;
      followers.remove(myUserId);
      UserData userData = state.userData.copyWith(followers: followers);
      await collectionRef.doc(userData.id).update(userData.toJson());
      List following = state.myData.following;
      following.remove(userData.id);
      UserData myData = state.myData.copyWith(following: following);
      await collectionRef.doc(myUserId).update(myData.toJson());
      emit(UnFollowedUserSearchState(
          state.posts,
          state.usersList,
          userData,
          state.tabIndex,
          state.postsIndex,
          state.usersPosts,
          myData,
          state.previousPage));
    } else {
      String userId = state.posts[event.index!].userId;
      var docSnapshot = await collectionRef.doc(userId).get();
      UserData userData = UserData.fromJson(docSnapshot.data()!);
      List followers = userData.followers;
      followers.remove(myUserId);
      await collectionRef
          .doc(userId)
          .update(userData.copyWith(followers: followers).toJson());
      List following = state.myData.following;
      following.remove(userId);
      UserData myData = state.myData.copyWith(following: following);
      await collectionRef.doc(myUserId).update(myData.toJson());
      emit(UnFollowedUserSearchState(
          state.posts,
          state.usersList,
          state.userData,
          state.tabIndex,
          state.postsIndex,
          state.usersPosts,
          myData,
          state.previousPage));
    }
  }

  Future<void> deletePost(DeleteSearchProfilePost event, Emitter emit) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    String? userId = sharedPreferences.getString("userId");
    List<Post> posts = List.from(state.userData.posts);
    posts.removeAt(event.index);
    UserData userData = state.userData.copyWith(posts: posts);
    await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .update(userData.toJson());
    emit(DeletedSearchProfilePostState(
        state.posts,
        state.usersList,
        userData,
        state.tabIndex,
        state.postsIndex,
        state.usersPosts,
        state.myData,
        state.previousPage));
  }

  Future<void> addBookmark(BookmarkSearch event, Emitter emit) async {
    List bookmarks = List.from(state.myData.bookmarks);
    String postId = state.usersPosts
        ? state.userData.posts[event.postIndex].id
        : state.posts[event.postIndex].id;
    if (bookmarks.contains(postId)) {
      bookmarks.remove(postId);
    } else {
      bookmarks.add(postId);
    }
    UserData myData = state.myData.copyWith(bookmarks: bookmarks);
    await FirebaseFirestore.instance
        .collection("users")
        .doc(myData.id)
        .update(myData.toJson());
    emit(BookmarkedSearchState(
        state.posts,
        state.usersList,
        state.userData,
        state.tabIndex,
        state.postsIndex,
        state.usersPosts,
        myData,
        state.previousPage));
  }

  Future<void> addComment(AddSearchComment event, Emitter emit) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    var collectionRef = FirebaseFirestore.instance.collection("users");
    List<Comments> existingComments = List.from(event.comments);
    String comment = event.comment;
    String? myUserId = sharedPreferences.getString('userId');
    String? profilePhotoUrl = sharedPreferences.getString('profilePhotoUrl');
    String? username = sharedPreferences.getString('username');
    String id = const Uuid().v4();
    Comments newComment =
        Comments(comment, profilePhotoUrl, username, myUserId, id);
    existingComments.add(newComment);
    if (state.usersPosts) {
      List<Post> posts = List.from(state.userData.posts);
      posts[event.postIndex] =
          posts[event.postIndex].copyWith(comments: existingComments);
      UserData userData = state.userData.copyWith(posts: posts);
      String userId = posts[event.postIndex].userId;
      await collectionRef.doc(userId).update(userData.toJson());
      emit(AddedCommentSearchState(
          state.posts,
          state.usersList,
          userData,
          state.tabIndex,
          state.postsIndex,
          state.usersPosts,
          state.myData,
          state.previousPage));
    } else {
      List<Post> posts = List.from(state.posts);
      posts[event.postIndex] =
          posts[event.postIndex].copyWith(comments: existingComments);
      String userId = posts[event.postIndex].userId;
      String postId = posts[event.postIndex].id;
      var documentSnapshot = await collectionRef.doc(userId).get();
      var documentData = documentSnapshot.data()!;
      for (int i = 0; i < documentData['posts'].length; i++) {
        if (documentData['posts'][i]['id'] == postId) {
          documentData['posts'][i]['comments'] =
              existingComments.map((comment) => comment.toJson());
        }
      }
      await collectionRef.doc(userId).update(documentData);
      emit(AddedCommentSearchState(
          posts,
          state.usersList,
          state.userData,
          state.tabIndex,
          state.postsIndex,
          state.usersPosts,
          state.myData,
          state.previousPage));
    }
    String notificationTitle = "Comment";
    String imageUrl = state.usersPosts
        ? state.userData.posts[event.postIndex].imageUrl
        : state.posts[event.postIndex].imageUrl;
    String body = "$username commented on your post";
    var userData = await collectionRef
        .doc(state.usersPosts
            ? state.userData.posts[event.postIndex].userId
            : state.posts[event.postIndex].userId)
        .get();
    List receiverFcmToken =
        List.generate(1, (index) => userData.data()!['fcmToken']);
    await NotificationService().sendNotification(
        notificationTitle, imageUrl, body, receiverFcmToken, false);
    var notificationCollectionRef =
        FirebaseFirestore.instance.collection("notifications");
    var notificationData =
        await notificationCollectionRef.doc(userData.data()!['id']).get();
    var notifications = [];
    if (notificationData.data() == null) {
      await notificationCollectionRef
          .doc(userData.data()!['id'])
          .set({"notifications": [], "new_notifications": false});
    } else {
      notifications = notificationData.data()!['notifications'];
    }
    NotificationData newNotification = NotificationData(
      const Uuid().v4(),
      username!,
      body,
      imageUrl,
      profilePhotoUrl!,
      DateTime.now().toString(),
      myUserId!,
    );
    notifications.add(newNotification.toJson());
    await notificationCollectionRef
        .doc(userData.data()!['id'])
        .update({"new_notifications": true, "notifications": notifications});
  }

  Future<void> deleteComment(DeleteSearchComment event, Emitter emit) async {
    List<Comments> existingComments = state.usersPosts
        ? List.from(state.userData.posts[event.postIndex].comments)
        : List.from(state.posts[event.postIndex].comments);
    if (state.usersPosts) {
      existingComments.removeAt(event.commentIndex);
      List<Post> posts = state.userData.posts;
      posts[event.postIndex] =
          posts[event.postIndex].copyWith(comments: existingComments);
      UserData userData = state.userData.copyWith(posts: posts);
      String userId = posts[event.postIndex].userId;
      await FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .update(userData.toJson());
      emit(DeletedCommentSearchState(
          state.posts,
          state.usersList,
          userData,
          state.tabIndex,
          state.postsIndex,
          state.usersPosts,
          state.myData,
          state.previousPage));
    } else {
      List<Post> posts = List.from(state.posts);
      String userId = posts[event.postIndex].userId;
      String commentId =
          posts[event.postIndex].comments[event.commentIndex].id!;
      var collectionRef = FirebaseFirestore.instance.collection("users");
      var docSnapshot = await collectionRef.doc(userId).get();
      var docData = docSnapshot.data()!;
      for (int i = 0; i < docData['posts'].length; i++) {
        List comments = docData['posts'][i]['comments'];
        for (int j = 0; j < comments.length; j++) {
          if (comments[j]['id'] == commentId) {
            comments.removeAt(j);
            docData['posts'][i]['comments'] = comments;
          }
        }
      }
      await collectionRef.doc(userId).update(docData);
      existingComments.removeAt(event.commentIndex);
      posts[event.postIndex] =
          posts[event.postIndex].copyWith(comments: existingComments);
      emit(DeletedCommentSearchState(
          posts,
          state.usersList,
          state.userData,
          state.tabIndex,
          state.postsIndex,
          state.usersPosts,
          state.myData,
          state.previousPage));
    }
  }

  Future<void> likePost(SearchLikePostEvent event, Emitter emit) async {
    bool liked = false;
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? myUserId = sharedPreferences.getString("userId");
    String? username = sharedPreferences.getString("username");
    String? profilePhotoUrl = sharedPreferences.getString("profilePhotoUrl");
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    final collectionRef = firebaseFirestore.collection("users");
    if (event.userPosts) {
      List<Post> posts = List.from(state.userData.posts);
      List likes = posts[event.postIndex].likes;
      if (likes.contains(myUserId)) {
        likes.remove(myUserId);
        liked = false;
      } else {
        likes.add(myUserId);
        liked = true;
      }
      posts[event.postIndex] = posts[event.postIndex].copyWith(likes: likes);
      UserData userData = state.userData.copyWith(posts: posts);
      emit(LikePostState(
          state.posts,
          state.usersList,
          userData,
          state.tabIndex,
          state.postsIndex,
          state.usersPosts,
          state.myData,
          state.previousPage));
      var docRef = collectionRef.doc(event.userId);
      var docData = await docRef.get();
      Map<String, dynamic> userDocData = docData.data()!;
      userDocData["posts"][event.postIndex]["likes"] = likes;
      await docRef.update(userDocData);
    } else {
      List<Post> posts = List.from(state.posts);
      List likes = posts[event.postIndex].likes;
      if (likes.contains(myUserId)) {
        likes.remove(myUserId);
      } else {
        likes.add(myUserId);
      }
      posts[event.postIndex] = posts[event.postIndex].copyWith(likes: likes);
      emit(LikePostState(
          posts,
          state.usersList,
          state.userData,
          state.tabIndex,
          state.postsIndex,
          state.usersPosts,
          state.myData,
          state.previousPage));
      var docsSnapshot =
          await collectionRef.where("id", isNotEqualTo: myUserId).get();
      var alldocs = docsSnapshot.docs;
      for (int i = 0; i < alldocs.length; i++) {
        Map<String, dynamic> documentData = alldocs[i].data();
        if (documentData["id"] == event.userId) {
          for (int j = 0; j < documentData["posts"].length; j++) {
            if (documentData["posts"][j]["id"] == event.postId) {
              documentData["posts"][j]["likes"] = likes;
              await collectionRef.doc(event.userId).set(documentData);
            }
          }
        }
      }
    }
    if (liked) {
      String notificationTitle = "Like";
      String imageUrl = event.userPosts
          ? state.userData.posts[event.postIndex].imageUrl
          : state.posts[event.postIndex].imageUrl;
      String body = "$username liked your post";
      var userData = await collectionRef
          .doc(event.userPosts
              ? state.userData.posts[event.postIndex].userId
              : state.posts[event.postIndex].userId)
          .get();
      List receiverFcmToken =
          List.generate(1, (index) => userData.data()!['fcmToken']);
      await NotificationService().sendNotification(
          notificationTitle, imageUrl, body, receiverFcmToken, false);
      var notificationCollectionRef =
          FirebaseFirestore.instance.collection("notifications");
      var notificationData =
          await notificationCollectionRef.doc(userData.data()!['id']).get();
      var notifications = [];
      if (notificationData.data() == null) {
        await notificationCollectionRef
            .doc(userData.data()!['id'])
            .set({"notifications": [], "new_notifications": false});
      } else {
        notifications = notificationData.data()!['notifications'];
      }
      NotificationData newNotification = NotificationData(
        const Uuid().v4(),
        username!,
        body,
        imageUrl,
        profilePhotoUrl!,
        DateTime.now().toString(),
        myUserId!,
      );
      notifications.add(newNotification.toJson());
      await notificationCollectionRef
          .doc(userData.data()!['id'])
          .update({"new_notifications": true, "notifications": notifications});
    }
  }

  Future<void> searchUsers(SearchUsers event, Emitter emit) async {
    emit(SearchInitial(
        state.posts,
        const <UserData>[],
        UserData.temp(),
        state.tabIndex,
        state.postsIndex,
        state.usersPosts,
        UserData.temp(),
        1));
    var sharedPreferences = await SharedPreferences.getInstance();
    String? userId = sharedPreferences.getString('userId');
    var firebaseCollectionRef = FirebaseFirestore.instance.collection("users");
    var result = await firebaseCollectionRef
        .orderBy("username")
        .startAt([event.text]).get();
    var docsList = result.docs;
    List<UserData> usersList = [];
    for (int i = 0; i < docsList.length; i++) {
      usersList.add(UserData.fromJson(docsList[i].data()));
    }
    var docSnapshot = await firebaseCollectionRef.doc(userId).get();
    var docData = docSnapshot.data()!;
    UserData myData = UserData.fromJson(docData);
    emit(UsersSearched(state.posts, usersList, UserData.temp(), state.tabIndex,
        state.postsIndex, state.usersPosts, myData, state.previousPage));
  }

  Future<void> getPosts(GetPosts event, Emitter emit) async {
    emit(SearchInitial(const <Post>[], const <UserData>[],
        UserData.temp(),
        state.tabIndex,
        state.postsIndex,
        state.usersPosts,
        UserData.temp(),
        1));
    var sharedPreferences = await SharedPreferences.getInstance();
    String? userId = sharedPreferences.getString('userId');
    var firestoreCollectionRef = FirebaseFirestore.instance.collection("users");
    var result =
        await firestoreCollectionRef.where("id", isNotEqualTo: userId).get();
    var docsList = result.docs;
    List<Post> posts = [];
    for (int i = 0; i < docsList.length; i++) {
      List postsList = docsList[i].data()['posts'];
      for (int j = 0; j < postsList.length; j++) {
        posts.add(Post.fromJson(postsList[j]));
      }
    }
    posts.shuffle();
    var docSnapshot = await firestoreCollectionRef.doc(userId).get();
    var docData = docSnapshot.data()!;
    UserData myData = UserData.fromJson(docData);
    emit(PostsFetched(
        posts,
        const <UserData>[],
        UserData.temp(),
        state.tabIndex,
        state.postsIndex,
        state.usersPosts,
        myData,
        state.previousPage));
  }
}
