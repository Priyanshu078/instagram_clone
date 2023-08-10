class NotificationData {
  String id;
  String username;
  String message;
  String imageUrl;
  String date;
  String userProfilePhoto;

  NotificationData(this.id, this.username, this.message, this.imageUrl,
      this.userProfilePhoto, this.date);

  factory NotificationData.fromJson(Map<String, dynamic> json) {
    return NotificationData(json['id'], json['username'], json['message'],
        json['imageUrl'], json['userProfilePhoto'], json['date']);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "username": username,
      "message": message,
      "imageUrl": imageUrl,
      "userProfilePhoto": userProfilePhoto,
      "date": date,
    };
  }
}
