class Post {
  String userId;
  String username;
  String imageUrl;
  int likes;
  List<String> comments;
  String caption;

  Post({
    required this.userId,
    required this.username,
    required this.imageUrl,
    required this.likes,
    required this.comments,
    required this.caption,
  });

  Post copyWith({
    String? userId,
    String? username,
    String? imageUrl,
    int? likes,
    List<String>? comments,
    String? caption,
  }) {
    return Post(
      userId: userId ?? this.userId,
      username: username ?? this.username,
      imageUrl: imageUrl ?? this.imageUrl,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
      caption: caption ?? this.caption,
    );
  }

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json["userId"],
      username: json["username"],
      imageUrl: json["imageUrl"],
      likes: json["likes"],
      comments: json["comments"],
      caption: json["caption"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "username": username,
      "imageUrl": imageUrl,
      "likes": likes,
      "comments": comments,
      "caption": caption,
    };
  }
}
