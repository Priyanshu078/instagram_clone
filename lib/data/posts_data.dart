class Post {
  String username;
  String imageUrl;
  int likes;
  List comments;
  String caption;

  Post({
    required this.username,
    required this.imageUrl,
    required this.likes,
    required this.comments,
    required this.caption,
  });

  Post copyWith({
    String? username,
    String? imageUrl,
    int? likes,
    List<String>? comments,
    String? caption,
  }) {
    return Post(
      username: username ?? this.username,
      imageUrl: imageUrl ?? this.imageUrl,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
      caption: caption ?? this.caption,
    );
  }

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      username: json["username"],
      imageUrl: json["imageUrl"],
      likes: json["likes"],
      comments: json["comments"],
      caption: json["caption"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "imageUrl": imageUrl,
      "likes": likes,
      "comments": comments,
      "caption": caption,
    };
  }
}
