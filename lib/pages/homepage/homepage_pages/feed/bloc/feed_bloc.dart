import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:instagram_clone/data/comment_data.dart';
import 'package:instagram_clone/data/posts_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
part 'feed_event.dart';
part 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  FeedBloc() : super(const FeedInitial(<Post>[])) {
    on<GetFeed>((event, emit) => getPosts(event, emit));
    on<PostLikeEvent>((event, emit) => likePost(event, emit));
    on<AddComment>((event, emit) => addComment(event, emit));
    on<DeleteFeedComment>((event, emit) => deleteComment(event, emit));
  }

  Future<void> deleteComment(DeleteFeedComment event, Emitter emit) async {
    List<Post> posts = List.from(state.posts);
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    String userId = posts[event.postIndex].userId;
    var collectionRef = firebaseFirestore.collection("users");
    var docRef = collectionRef.doc(userId);
    var documentSnapshot = await docRef.get();
    var documentData = documentSnapshot.data()!;
    for (int i = 0; i < documentData["posts"].length; i++) {
      if (documentData["posts"][i]['id'] == state.posts[event.postIndex].id) {
        List comments = documentData["posts"][i]['comments'];
        for (int j = 0; j < comments.length; j++) {
          if (comments[j]['id'] ==
              state.posts[event.postIndex].comments[event.commentIndex].id) {
            comments.removeAt(j);
            documentData["posts"][i]['comments'] = comments;
          }
        }
      }
    }
    posts[event.postIndex].comments.removeAt(event.commentIndex);
    await docRef.update(documentData);
    emit(CommentDeletedState(posts));
  }

  Future<void> addComment(AddComment event, Emitter emit) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    var collectionRef = firebaseFirestore.collection("users");
    List<Post> posts = List.from(state.posts);
    String? profilePhotoUrl = sharedPreferences.getString('profilePhotoUrl');
    String? username = sharedPreferences.getString('username');
    String? myUserId = sharedPreferences.getString("userId");
    String id = const Uuid().v4();
    Comments newComment =
        Comments(event.comment, profilePhotoUrl, username, myUserId, id);
    List<Comments> exisitingComments = event.comments;
    exisitingComments.add(newComment);
    posts[event.postIndex].comments = exisitingComments;
    String userId = posts[event.postIndex].userId;
    var docRef = collectionRef.doc(userId);
    var documentSnapshot = await docRef.get();
    var documentData = documentSnapshot.data()!;
    for (int i = 0; i < documentData["posts"].length; i++) {
      if (documentData["posts"][i]["id"] == posts[event.postIndex].id) {
        List comments = [];
        for (Comments element in exisitingComments) {
          comments.add(element.toJson());
        }
        documentData["posts"][i]['comments'] = comments;
      }
    }
    await docRef.update(documentData);
    emit(CommentAddedState(posts));
  }

  Future<void> likePost(PostLikeEvent event, Emitter emit) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? userId = sharedPreferences.getString("userId");
    var firestore = FirebaseFirestore.instance;
    var collectionRef = firestore.collection("users");
    var docsSnapshot =
        await collectionRef.where("id", isNotEqualTo: userId).get();
    var alldocs = docsSnapshot.docs;
    List<Post> posts = List.from(state.posts);
    List likes = posts[event.index].likes;
    if (likes.contains(userId)) {
      likes.remove(userId);
    } else {
      likes.add(userId);
    }
    posts[event.index] = posts[event.index].copyWith(likes: likes);
    emit(PostLikedState(posts));
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
    if (event.atStart) {
      posts.shuffle();
    }
    emit(FeedFetched(posts));
  }
}
