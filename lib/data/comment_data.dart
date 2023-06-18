class Comments {
  String? comment;
  String? username;
  String? profilePhotoUrl;
  String? userId;
  String? id;

  Comments(
      this.comment, this.profilePhotoUrl, this.username, this.userId, this.id);

  Comments.fromJson(Map<String, dynamic> json) {
    comment = json['comment'];
    profilePhotoUrl = json['profilePhotoUrl'];
    username = json['username'];
    userId = json['userId'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    return {
      "comment": comment,
      "username": username,
      "profilePhotoUrl": profilePhotoUrl,
      "userId": userId,
      "id": id,
    };
  }
}
