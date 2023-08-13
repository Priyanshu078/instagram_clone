class NotificationData {
  String id;
  String username;
  String message;
  String imageUrl;
  String dateTime;
  String userProfilePhoto;
  String senderUserId;

  NotificationData(this.id, this.username, this.message, this.imageUrl,
      this.userProfilePhoto, this.dateTime, this.senderUserId);

  factory NotificationData.fromJson(Map<String, dynamic> json) {
    return NotificationData(
        json['id'],
        json['username'],
        json['message'],
        json['imageUrl'],
        json['userProfilePhoto'],
        json['dateTime'],
        json['senderUserId']);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "username": username,
      "message": message,
      "imageUrl": imageUrl,
      "userProfilePhoto": userProfilePhoto,
      "dateTime": dateTime,
      "senderUserId": senderUserId,
    };
  }
}
