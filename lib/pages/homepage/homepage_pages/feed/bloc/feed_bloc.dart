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
part 'feed_event.dart';
part 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final PageController pageController;

  FeedBloc(this.pageController)
      : super(FeedInitial(const <Post>[], UserData.temp(), UserData.temp(), 0,
            0, const [], StoryData(story: Story.temp(), viewed: false))) {
    on<GetFeed>((event, emit) => getPosts(event, emit));
    on<PostLikeEvent>((event, emit) => likePost(event, emit));
    on<AddFeedComment>((event, emit) => addComment(event, emit));
    on<DeleteFeedComment>((event, emit) => deleteComment(event, emit));
    on<BookmarkFeed>((event, emit) => addBookmark(event, emit));
    on<FetchUserData>((event, emit) => fetchUserData(event, emit));
    on<TabChangeFeedEvent>((event, emit) => emit(TabChangedFeedState(
        state.posts,
        state.myData,
        state.userData,
        event.tabIndex,
        state.postsIndex,
        state.stories,
        state.myStory)));
    on<FeedPostsIndexChangeEvent>((event, emit) => emit(
        PostIndexChangeFeedState(state.posts, state.myData, state.userData,
            state.tabIndex, event.postIndex, state.stories, state.myStory)));
    on<GetMyStory>((event, emit) => getMyStory(event, emit));
    on<DeleteMyStory>((event, emit) => deleteMyStory(event, emit));
    on<FollowFeedEvent>((event, emit) => follow(event, emit));
    on<UnFollowFeedEvent>((event, emit) => unfollow(event, emit));
    on<StoryViewEvent>((event, emit) => viewStory(event, emit));
    on<ShareFileEvent>((event, emit) => shareFile(event, emit));
  }

  Future<void> shareFile(ShareFileEvent event, Emitter emit) async {
    var response = await Dio().get(event.imageUrl,
        options: Options(responseType: ResponseType.bytes));
    Directory dir = await getTemporaryDirectory();
    File file = File('${dir.path}/image.png');
    await file.writeAsBytes(response.data);
    await Share.shareXFiles([XFile(file.path)], text: event.caption);
  }

  Future<void> viewStory(StoryViewEvent event, Emitter emit) async {
    var collectionRef = FirebaseFirestore.instance.collection("stories");
    if (event.viewMyStory) {
      StoryData myStory = state.myStory.copyWith(viewed: true);
      await collectionRef.doc(myStory.story.userId).update({"viewed": true});
      emit(StoryViewedState(state.posts, state.myData, state.userData,
          state.tabIndex, state.postsIndex, state.stories, myStory));
    } else {
      List<StoryData> stories = List.from(state.stories);
      stories[event.index!] =
          StoryData(story: stories[event.index!].story, viewed: true);
      await collectionRef
          .doc(stories[event.index!].story.userId)
          .update({"viewed": true});
      emit(StoryViewedState(state.posts, state.myData, state.userData,
          state.tabIndex, state.postsIndex, stories, state.myStory));
    }
  }

  Future<void> unfollow(UnFollowFeedEvent event, Emitter emit) async {
    emit(UnFollowingFeedState(state.posts, state.myData, state.userData,
        state.tabIndex, state.postsIndex, state.stories, state.myStory));
    var sharedPreferences = await SharedPreferences.getInstance();
    String? myUserId = sharedPreferences.getString("userId");
    var collectionRef = FirebaseFirestore.instance.collection("users");
    if (event.fromFeed) {
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
      emit(UnFollowedUserFeedState(state.posts, myData, state.userData,
          state.tabIndex, state.postsIndex, state.stories, state.myStory));
    } else {
      List followers = state.userData.followers;
      followers.remove(myUserId);
      UserData userData = state.userData.copyWith(followers: followers);
      await collectionRef.doc(userData.id).update(userData.toJson());
      List following = state.myData.following;
      following.remove(userData.id);
      UserData myData = state.myData.copyWith(following: following);
      await collectionRef.doc(myUserId).update(myData.toJson());
      emit(UnFollowedUserFeedState(state.posts, myData, userData,
          state.tabIndex, state.postsIndex, state.stories, state.myStory));
    }
  }

  Future<void> follow(FollowFeedEvent event, Emitter emit) async {
    emit(FollowingFeedState(state.posts, state.myData, state.userData,
        state.tabIndex, state.postsIndex, state.stories, state.myStory));
    var sharedPreferences = await SharedPreferences.getInstance();
    String? myUserId = sharedPreferences.getString("userId");
    String? username = sharedPreferences.getString("username");
    String? userProfilePhotoUrl =
        sharedPreferences.getString("profilePhotoUrl");
    var collectionRef = FirebaseFirestore.instance.collection("users");
    if (event.fromFeed) {
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
      emit(FollowedUserFeedState(state.posts, myData, state.userData,
          state.tabIndex, state.postsIndex, state.stories, state.myStory));
    } else {
      List followers = state.userData.followers;
      followers.add(myUserId);
      UserData userData = state.userData.copyWith(followers: followers);
      await collectionRef.doc(userData.id).update(userData.toJson());
      List following = state.myData.following;
      following.add(userData.id);
      UserData myData = state.myData.copyWith(following: following);
      await collectionRef.doc(myUserId).update(myData.toJson());
      emit(FollowedUserFeedState(state.posts, myData, userData, state.tabIndex,
          state.postsIndex, state.stories, state.myStory));
    }
    String title = "New Follower";
    String imageUrl = "";
    String body = "$username started following you";
    var userData = await collectionRef
        .doc(event.fromFeed
            ? state.posts[event.index!].userId
            : state.userData.id)
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

  Future<void> deleteMyStory(DeleteMyStory event, Emitter emit) async {
    UserData myData = state.myData.copyWith(addedStory: false);
    StoryData myStory = StoryData(story: Story.temp(), viewed: false);
    emit(MyStoryDeletedState(state.posts, myData, state.userData,
        state.tabIndex, state.postsIndex, state.stories, myStory));
  }

  Future<void> getMyStory(GetMyStory event, Emitter emit) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    String? myUserId = sharedPreferences.getString("userId");
    var docSnapshot = await FirebaseFirestore.instance
        .collection("stories")
        .doc(myUserId)
        .get();
    var docData = docSnapshot.data()!;
    StoryData myStory = StoryData(
        story: Story.fromJson(docData["previous_stories"].last), viewed: false);
    UserData myData = state.myData.copyWith(addedStory: true);
    emit(MyStoryFetchedState(state.posts, myData, state.userData,
        state.tabIndex, state.postsIndex, state.stories, myStory));
  }

  Future<void> fetchUserData(FetchUserData event, Emitter emit) async {
    emit(UserDataLoadingState(state.posts, state.myData, state.userData,
        state.tabIndex, state.postsIndex, state.stories, state.myStory));
    String userId = event.userId;
    var docSnapshot =
        await FirebaseFirestore.instance.collection("users").doc(userId).get();
    UserData userData = UserData.fromJson(docSnapshot.data()!);
    emit(UserDataFetchedState(state.posts, state.myData, userData,
        state.tabIndex, state.postsIndex, state.stories, state.myStory));
  }

  Future<void> addBookmark(BookmarkFeed event, Emitter emit) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    String? myUserId = sharedPreferences.getString("userId");
    List bookmarks = List.from(state.myData.bookmarks);
    String postId = event.inFeed
        ? state.posts[event.postIndex].id
        : state.userData.posts[event.postIndex].id;
    if (bookmarks.contains(postId)) {
      bookmarks.remove(postId);
    } else {
      bookmarks.add(postId);
    }
    UserData myData = state.myData.copyWith(bookmarks: bookmarks);
    await FirebaseFirestore.instance
        .collection("users")
        .doc(myUserId)
        .update(myData.toJson());
    emit(BookmarkedState(state.posts, myData, state.userData, state.tabIndex,
        state.postsIndex, state.stories, state.myStory));
  }

  Future<void> deleteComment(DeleteFeedComment event, Emitter emit) async {
    List<Post> posts =
        event.inFeed ? List.from(state.posts) : List.from(state.userData.posts);
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    String userId = posts[event.postIndex].userId;
    var collectionRef = firebaseFirestore.collection("users");
    var docRef = collectionRef.doc(userId);
    var documentSnapshot = await docRef.get();
    var documentData = documentSnapshot.data()!;
    for (int i = 0; i < documentData["posts"].length; i++) {
      if (documentData["posts"][i]['id'] == posts[event.postIndex].id) {
        List comments = documentData["posts"][i]['comments'];
        for (int j = 0; j < comments.length; j++) {
          if (comments[j]['id'] ==
              posts[event.postIndex].comments[event.commentIndex].id) {
            comments.removeAt(j);
            documentData["posts"][i]['comments'] = comments;
          }
        }
      }
    }
    List<Comments> comments = posts[event.postIndex].comments;
    comments.removeAt(event.commentIndex);
    posts[event.postIndex] =
        posts[event.postIndex].copyWith(comments: comments);
    await docRef.update(documentData);
    if (event.inFeed) {
      emit(CommentDeletedState(posts, state.myData, state.userData,
          state.tabIndex, state.postsIndex, state.stories, state.myStory));
    } else {
      UserData userData = state.userData.copyWith(posts: posts);
      emit(CommentDeletedState(state.posts, state.myData, userData,
          state.tabIndex, state.postsIndex, state.stories, state.myStory));
    }
  }

  Future<void> addComment(AddFeedComment event, Emitter emit) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    var userProfilePhotoUrl = sharedPreferences.getString("profilePhotoUrl");
    var collectionRef = firebaseFirestore.collection("users");
    String? profilePhotoUrl = sharedPreferences.getString('profilePhotoUrl');
    String? username = sharedPreferences.getString('username');
    String? myUserId = sharedPreferences.getString("userId");
    String id = const Uuid().v4();
    Comments newComment =
        Comments(event.comment, profilePhotoUrl, username, myUserId, id);
    List<Comments> existingComments = event.comments;
    existingComments.add(newComment);
    if (event.inFeed) {
      List<Post> posts = List.from(state.posts);
      posts[event.postIndex].comments = existingComments;
      String userId = posts[event.postIndex].userId;
      var docRef = collectionRef.doc(userId);
      var documentSnapshot = await docRef.get();
      var documentData = documentSnapshot.data()!;
      for (int i = 0; i < documentData["posts"].length; i++) {
        if (documentData["posts"][i]["id"] == posts[event.postIndex].id) {
          List comments = [];
          for (Comments element in existingComments) {
            comments.add(element.toJson());
          }
          documentData["posts"][i]['comments'] = comments;
        }
      }
      await docRef.update(documentData);
      emit(CommentAddedState(posts, state.myData, state.userData,
          state.tabIndex, state.postsIndex, state.stories, state.myStory));
    } else {
      List<Post> posts = List.from(state.userData.posts);
      posts[event.postIndex] =
          posts[event.postIndex].copyWith(comments: existingComments);
      UserData userData = state.userData.copyWith(posts: posts);
      String userId = posts[event.postIndex].userId;
      await FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .update(userData.toJson());
      emit(CommentAddedState(state.posts, state.myData, userData,
          state.tabIndex, state.postsIndex, state.stories, state.myStory));
    }
    String title = "Comment";
    String imageUrl = event.inFeed
        ? state.posts[event.postIndex].imageUrl
        : state.userData.posts[event.postIndex].imageUrl;
    String body = "$username commented on your photo";
    var userData = await collectionRef
        .doc(event.inFeed
            ? state.posts[event.postIndex].userId
            : state.userData.posts[event.postIndex].userId)
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

  Future<void> likePost(PostLikeEvent event, Emitter emit) async {
    bool liked = false;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? userId = sharedPreferences.getString("userId");
    String? username = sharedPreferences.getString("username");
    String? userProfilePhotoUrl =
        sharedPreferences.getString("profilePhotoUrl");
    var firestore = FirebaseFirestore.instance;
    var collectionRef = firestore.collection("users");
    List<Post> posts =
        event.inFeed ? List.from(state.posts) : List.from(state.userData.posts);
    List likes = posts[event.index].likes;
    if (likes.contains(userId)) {
      likes.remove(userId);
      liked = false;
    } else {
      likes.add(userId);
      liked = true;
    }
    posts[event.index] = posts[event.index].copyWith(likes: likes);
    var docSnapshot = await collectionRef.doc(event.userId).get();
    List<Post> userPosts = UserData.fromJson(docSnapshot.data()!).posts;
    for (int i = 0; i < userPosts.length; i++) {
      if (userPosts[i].id == event.postId) {
        if (event.inFeed) {
          UserData userdata = UserData.fromJson(docSnapshot.data()!);
          userPosts[i] = userPosts[i].copyWith(likes: likes);
          await collectionRef
              .doc(event.userId)
              .update(userdata.copyWith(posts: userPosts).toJson());
        } else {
          userPosts[i] = userPosts[i].copyWith(likes: likes);
          UserData userData = state.userData.copyWith(posts: userPosts);
          await collectionRef.doc(event.userId).update(userData.toJson());
        }
      }
    }
    if (event.inFeed) {
      emit(PostLikedState(posts, state.myData, state.userData, state.tabIndex,
          state.postsIndex, state.stories, state.myStory));
    } else {
      UserData userData = state.userData.copyWith(posts: posts);
      emit(PostLikedState(state.posts, state.myData, userData, state.tabIndex,
          state.postsIndex, state.stories, state.myStory));
    }
    if (liked) {
      String title = "Like";
      String imageUrl = posts[event.index].imageUrl;
      String body = "$username liked your photo";
      var userData = await collectionRef.doc(posts[event.index].userId).get();
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
          userId!);
      notifications.add(newNotification.toJson());
      await notificationCollectionRef
          .doc(userData.data()!['id'])
          .update({"new_notifications": true, "notifications": notifications});
    }
  }

  Future<void> getPosts(GetFeed event, Emitter emit) async {
    emit(FeedInitial(const <Post>[], UserData.temp(), UserData.temp(), 0, 0,
        const [], StoryData(story: Story.temp(), viewed: false)));
    var sharedPreferences = await SharedPreferences.getInstance();
    String? userId = sharedPreferences.getString('userId');
    var firestoreCollectionRef = FirebaseFirestore.instance.collection("users");
    var docSnapshot = await firestoreCollectionRef.doc(userId).get();
    UserData myData = UserData.fromJson(docSnapshot.data()!);
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
    if (event.atStart) {
      posts.shuffle();
    }
    var storiesCollectionRef = FirebaseFirestore.instance.collection("stories");
    String todaysDate = DateTime.now().toString().split(" ")[0];
    StoryData myStory = StoryData(story: Story.temp(), viewed: false);
    if (myData.addedStory) {
      var storySnapshot = await storiesCollectionRef.doc(userId).get();
      if (storySnapshot.data()!['previous_stories'].last['date'] !=
          todaysDate) {
        myData = myData.copyWith(addedStory: false);
        myStory = StoryData(story: Story.temp(), viewed: false);
        await storiesCollectionRef.doc(userId).update({"addedStory": false});
        await firestoreCollectionRef.doc(userId).update({"addedStory": false});
      } else {
        myStory = StoryData(
            story:
                Story.fromJson(storySnapshot.data()!["previous_stories"].last),
            viewed: storySnapshot.data()!['viewed']);
      }
    }
    var peopleAddedStoriesSnapshot = await storiesCollectionRef
        .where("addedStory", isEqualTo: true)
        .where("userId", isNotEqualTo: userId)
        .get();
    var peopleAddedStoryDocs = peopleAddedStoriesSnapshot.docs;
    List<StoryData> stories = [];
    for (int i = 0; i < peopleAddedStoryDocs.length; i++) {
      if (peopleAddedStoryDocs[i].data()['previous_stories'].last['date'] ==
          todaysDate) {
        stories.add(StoryData(
            story: Story.fromJson(
                peopleAddedStoryDocs[i].data()["previous_stories"].last),
            viewed: peopleAddedStoryDocs[i].data()['viewed']));
      }
    }
    emit(FeedFetched(
      posts,
      myData,
      state.userData,
      state.tabIndex,
      state.postsIndex,
      stories,
      myStory,
    ));
    for (int i = 0; i < peopleAddedStoryDocs.length; i++) {
      if (peopleAddedStoryDocs[i].data()['previous_stories'].last['date'] !=
          todaysDate) {
        await FirebaseFirestore.instance
            .collection("users")
            .doc(peopleAddedStoryDocs[i].id)
            .update({"addedStory": false});
        await FirebaseFirestore.instance
            .collection("stories")
            .doc(peopleAddedStoryDocs[i].id)
            .update({"addedStory": false});
      }
    }
  }
}
