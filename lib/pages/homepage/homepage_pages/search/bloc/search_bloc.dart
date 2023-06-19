import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:instagram_clone/data/comment_data.dart';
import 'package:instagram_clone/data/posts_data.dart';
import 'package:instagram_clone/data/user_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final PageController pageController;
  final FocusNode focusNode;
  final TextEditingController searchController;

  SearchBloc(this.pageController, this.focusNode, this.searchController)
      : super(SearchInitial(
            const <Post>[], const <UserData>[], UserData.temp(), 0, 0, true)) {
    on<GetPosts>((event, emit) => getPosts(event, emit));
    on<SearchUsers>((event, emit) => searchUsers(event, emit));
    on<UserProfileEvent>((event, emit) => emit(UserProfileState(
        state.posts,
        state.usersList,
        event.userData,
        state.tabIndex,
        state.postsIndex,
        state.usersPosts)));
    on<UserProfileBackEvent>((event, emit) => emit(UsersSearched(
        state.posts,
        state.usersList,
        state.userData,
        state.tabIndex,
        state.postsIndex,
        state.usersPosts)));
    on<TabChangeEvent>((event, emit) => emit(TabChangeState(
        state.posts,
        state.usersList,
        state.userData,
        event.tabIndex,
        state.postsIndex,
        state.usersPosts)));
    on<PostsIndexChangeEvent>((event, emit) => emit(PostIndexChangedState(
        state.posts,
        state.usersList,
        state.userData,
        state.tabIndex,
        event.postIndex,
        event.usersPosts)));
    on<SearchLikePostEvent>((event, emit) => likePost(event, emit));
    on<AddSearchComment>((event, emit) => addComment(event, emit));
    on<DeleteSearchComment>((event, emit) => deleteComment(event, emit));
  }

  Future<void> addComment(AddSearchComment event, Emitter emit) async {
    var sharedPreferences = await SharedPreferences.getInstance();
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
      await FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .update(userData.toJson());
      emit(AddedCommentSearchState(state.posts, state.usersList, userData,
          state.tabIndex, state.postsIndex, state.usersPosts));
    } else {
      List<Post> posts = List.from(state.posts);
      posts[event.postIndex] =
          posts[event.postIndex].copyWith(comments: existingComments);
      String userId = posts[event.postIndex].userId;
      String postId = posts[event.postIndex].id;
      var collectionRef = FirebaseFirestore.instance.collection("users");
      var documentSnapshot = await collectionRef.doc(userId).get();
      var documentData = documentSnapshot.data()!;
      for (int i = 0; i < documentData['posts'].length; i++) {
        if (documentData['posts'][i]['id'] == postId) {
          documentData['posts'][i]['comments'] =
              existingComments.map((comment) => comment.toJson());
        }
      }
      await FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .update(documentData);
      emit(AddedCommentSearchState(posts, state.usersList, state.userData,
          state.tabIndex, state.postsIndex, state.usersPosts));
    }
  }

  Future<void> deleteComment(DeleteSearchComment event, Emitter emit) async {}

  Future<void> likePost(SearchLikePostEvent event, Emitter emit) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? myUserId = sharedPreferences.getString("userId");
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    final collectionRef = firebaseFirestore.collection("users");
    if (event.userPosts) {
      List<Post> posts = List.from(state.userData.posts);
      List likes = posts[event.postIndex].likes;
      if (likes.contains(myUserId)) {
        likes.remove(myUserId);
      } else {
        likes.add(myUserId);
      }
      posts[event.postIndex] = posts[event.postIndex].copyWith(likes: likes);
      UserData userData = state.userData.copyWith(posts: posts);
      emit(LikePostState(state.posts, state.usersList, userData, state.tabIndex,
          state.postsIndex, state.usersPosts));
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
      emit(LikePostState(posts, state.usersList, state.userData, state.tabIndex,
          state.postsIndex, state.usersPosts));
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
  }

  Future<void> searchUsers(SearchUsers event, Emitter emit) async {
    emit(SearchInitial(state.posts, const <UserData>[], UserData.temp(),
        state.tabIndex, state.postsIndex, state.usersPosts));
    var firebaseCollectionRef = FirebaseFirestore.instance.collection("users");
    var result = await firebaseCollectionRef
        .orderBy("username")
        .startAt([event.text]).get();
    var docsList = result.docs;
    List<UserData> usersList = [];
    for (int i = 0; i < docsList.length; i++) {
      usersList.add(UserData.fromJson(docsList[i].data()));
    }
    emit(UsersSearched(state.posts, usersList, UserData.temp(), state.tabIndex,
        state.postsIndex, state.usersPosts));
  }

  Future<void> getPosts(GetPosts event, Emitter emit) async {
    emit(SearchInitial(const <Post>[], const <UserData>[], UserData.temp(),
        state.tabIndex, state.postsIndex, state.usersPosts));
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
    emit(PostsFetched(posts, const <UserData>[], UserData.temp(),
        state.tabIndex, state.postsIndex, state.usersPosts));
  }
}
