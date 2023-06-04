import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:instagram_clone/data/posts_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(const SearchInitial(<Post>[])) {
    on<GetPosts>((event, emit) => getPosts(event, emit));
  }

  Future<void> getPosts(GetPosts event, Emitter emit) async {
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
    emit(PostsFetched(posts));
  }
}
