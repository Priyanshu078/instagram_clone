class Comments {
  String? comment;
  String? username;
  String? profilePhotoUrl;
  String? userId;

  Comments(this.comment, this.profilePhotoUrl, this.username, this.userId);

  Comments.fromJson(Map<String, dynamic> json) {
    comment = json['comment'];
    profilePhotoUrl = json['profilePhotoUrl'];
    username = json['username'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    return {
      "comment": comment,
      "username": username,
      "profilePhotoUrl": profilePhotoUrl,
      "userId": userId,
    };
  }
}
