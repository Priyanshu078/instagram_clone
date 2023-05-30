part of 'posts_bloc.dart';

abstract class PostsState extends Equatable {
  const PostsState();
  
  @override
  List<Object> get props => [];
}

class PostsInitial extends PostsState {}
