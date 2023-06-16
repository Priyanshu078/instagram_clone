import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:instagram_clone/data/posts_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'feed_event.dart';
part 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  FeedBloc() : super(const FeedInitial(<Post>[])) {
    on<GetFeed>((event, emit) => getPosts(event, emit));
    on<PostLikeEvent>((event, emit) => likePost(event, emit));
  }

  Future<void> likePost(PostLikeEvent event, Emitter emit) async {}

  Future<void> getPosts(GetFeed event, Emitter emit) async {
    emit(const FeedInitial(<Post>[]));
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
