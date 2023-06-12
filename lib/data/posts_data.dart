class Post {
  String userProfilePhotoUrl;
  String username;
  String imageUrl;
  int likes;
  List comments;
  String caption;
  String userId;

  Post({
    required this.username,
    required this.imageUrl,
    required this.likes,
    required this.comments,
    required this.caption,
    required this.userId,
    required this.userProfilePhotoUrl,
  });

  Post copyWith({
    String? username,
    String? imageUrl,
    int? likes,
    List<String>? comments,
    String? caption,
    String? userId,
    String? userProfilePhotoUrl,
  }) {
    return Post(
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
      username: json["username"],
      imageUrl: json["imageUrl"],
      likes: json["likes"],
      comments: json["comments"],
      caption: json["caption"],
      userId: json['userId'],
      userProfilePhotoUrl: json['userProfilePhotoUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "imageUrl": imageUrl,
      "likes": likes,
      "comments": comments,
      "caption": caption,
      "userId": userId,
      "userProfilePhotoUrl": userProfilePhotoUrl,
    };
  }
}
