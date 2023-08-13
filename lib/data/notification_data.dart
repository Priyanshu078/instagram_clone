class NotificationData {
  String id;
  String username;
  String message;
  String imageUrl;
  String date;
  String userProfilePhoto;
  String senderUserId;

  NotificationData(this.id, this.username, this.message, this.imageUrl,
      this.userProfilePhoto, this.date, this.senderUserId);

  factory NotificationData.fromJson(Map<String, dynamic> json) {
    return NotificationData(
        json['id'],
        json['username'],
        json['message'],
        json['imageUrl'],
        json['userProfilePhoto'],
        json['date'],
        json['senderUserId']);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "username": username,
      "message": message,
      "imageUrl": imageUrl,
      "userProfilePhoto": userProfilePhoto,
      "dateTime": date,
      "senderUserId": senderUserId,
    };
  }
}
