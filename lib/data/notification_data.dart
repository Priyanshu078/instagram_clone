class Notification {
  String id;
  String username;
  String message;
  String imageUrl;
  String date;
  String userProfilePhoto;

  Notification(this.id, this.username, this.message, this.imageUrl,
      this.userProfilePhoto, this.date);

  Notification fromJson(Map<String, dynamic> json) {
    return Notification(json['id'], json['username'], json['message'],
        json['imageUrl'], json['userProfilePhoto'], json['date']);
  }
}
