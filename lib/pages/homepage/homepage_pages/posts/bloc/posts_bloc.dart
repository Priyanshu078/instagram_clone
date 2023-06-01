import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc() : super(PostsInitial()) {
    on<ChooseImage>((event, emit) => chooseImage(event, emit));
    on<CancelEvent>((event, emit) => emit(PostsInitial()));
  }

  Future<void> chooseImage(ChooseImage event, Emitter emit) async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      File file = File(image.path);
      emit(PostReady(file));
    } else {
      emit(PostsInitial());
    }
  }
}
