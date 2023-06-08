import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:instagram_clone/data/posts_data.dart';
import 'package:instagram_clone/data/user_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final PageController pageController;

  SearchBloc(this.pageController)
      : super(SearchInitial(
            const <Post>[], const <UserData>[], UserData.temp())) {
    on<GetPosts>((event, emit) => getPosts(event, emit));
    on<SearchUsers>((event, emit) => searchUsers(event, emit));
    on<UserProfileEvent>((event, emit) =>
        emit(UserProfileState(state.posts, state.usersList, event.userData)));
    on<UserProfileBackEvent>((event, emit) =>
        emit(UsersSearched(state.posts, state.usersList, state.userData)));
  }

  Future<void> searchUsers(SearchUsers event, Emitter emit) async {
    emit(SearchInitial(state.posts, const <UserData>[], UserData.temp()));
    var firebaseCollectionRef = FirebaseFirestore.instance.collection("users");
    var result = await firebaseCollectionRef
        .orderBy("username")
        .startAt([event.text]).get();
    var docsList = result.docs;
    List<UserData> usersList = [];
    for (int i = 0; i < docsList.length; i++) {
      usersList.add(UserData.fromJson(docsList[i].data()));
    }
    emit(UsersSearched(state.posts, usersList, UserData.temp()));
  }

  Future<void> getPosts(GetPosts event, Emitter emit) async {
    emit(SearchInitial(const <Post>[], const <UserData>[], UserData.temp()));
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
    emit(PostsFetched(posts, const <UserData>[], UserData.temp()));
  }
}
