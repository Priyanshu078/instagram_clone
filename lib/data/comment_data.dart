class Comments {
  String? comment;
  String? username;
  String? profilePhotoUrl;

  Comments(this.comment, this.profilePhotoUrl, this.username);

  Comments.fromJson(Map<String, dynamic> json) {
    comment = json['comment'];
    profilePhotoUrl = json['profilePhotoUrl'];
    username = json['username'];
  }
}
