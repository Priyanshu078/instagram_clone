import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/data/posts_data.dart';
import 'package:instagram_clone/data/user_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc() : super(const PostsInitial("")) {
    on<ChooseImage>((event, emit) => chooseImage(event, emit));
    on<CancelEvent>((event, emit) => emit(const PostsInitial("")));
    on<PostImage>((event, emit) => postImage(event, emit));
  }

  Future<void> chooseImage(ChooseImage event, Emitter emit) async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      emit(PostReady(image.path));
    } else {
      emit(const PostsInitial(""));
    }
  }

  Future<void> postImage(PostImage event, Emitter emit) async {
    emit(PostingImageState(state.imagePath));
    var sharedPreferences = await SharedPreferences.getInstance();
    var userId = sharedPreferences.getString('userId');
    var caption = event.caption;
    var collectionRef = FirebaseFirestore.instance.collection("users");
    var data = await collectionRef.doc(userId).get();
    UserData userData = UserData.fromJson(data.data()!);
    String username = userData.username;
    var ref = FirebaseStorage.instance.ref();

    Post post = Post(
      username: username,
      imageUrl: imageUrl,
      likes: 0,
      comments: <String>[],
      caption: caption,
    );
  }
}
