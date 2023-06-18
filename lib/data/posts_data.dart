import 'package:instagram_clone/data/comment_data.dart';

class Post {
  String id;
  String userProfilePhotoUrl;
  String username;
  String imageUrl;
  List likes;
  List<Comments> comments;
  String caption;
  String userId;

  Post({
    required this.id,
    required this.username,
    required this.imageUrl,
    required this.likes,
    required this.comments,
    required this.caption,
    required this.userId,
    required this.userProfilePhotoUrl,
  });

  Post copyWith({
    String? id,
    String? username,
    String? imageUrl,
    List? likes,
    List<Comments>? comments,
    String? caption,
    String? userId,
    String? userProfilePhotoUrl,
  }) {
    return Post(
      id: id ?? this.id,
      username: username ?? this.username,
      imageUrl: imageUrl ?? this.imageUrl,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
      caption: caption ?? this.caption,
      userId: userId ?? this.userId,
      userProfilePhotoUrl: userProfilePhotoUrl ?? this.userProfilePhotoUrl,
    );
  }

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      username: json["username"],
      imageUrl: json["imageUrl"],
      likes: json["likes"],
      comments: List.from(json["comments"].map((comment) => Comments(
            comment["comment"],
            comment['profilePhotoUrl'],
            comment['username'],
            comment['userId'],
            comment['id'],
          ))),
      caption: json["caption"],
      userId: json['userId'],
      userProfilePhotoUrl: json['userProfilePhotoUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "username": username,
      "imageUrl": imageUrl,
      "likes": likes,
      "comments": comments.map((e) => e.toJson()),
      "caption": caption,
      "userId": userId,
      "userProfilePhotoUrl": userProfilePhotoUrl,
    };
  }
}
