class StoryData {
  final Story story;
  final bool viewed;

  StoryData({
    required this.story,
    required this.viewed,
  });

  StoryData copyWith({Story? story, bool? viewed}) {
    return StoryData(
      story: story ?? this.story,
      viewed: viewed ?? this.viewed,
    );
  }
}

class Story {
  final String id;
  final String userProfilePhotoUrl;
  final String username;
  final String imageUrl;
  final String caption;
  final String userId;

  Story({
    required this.id,
    required this.userProfilePhotoUrl,
    required this.username,
    required this.imageUrl,
    required this.caption,
    required this.userId,
  });

  factory Story.fromJson(Map<String, dynamic> json) {
    return Story(
      id: json["id"],
      userProfilePhotoUrl: json["userProfilePhotoUrl"],
      username: json["username"],
      imageUrl: json["imageUrl"],
      caption: json["caption"],
      userId: json["userId"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "userProfilePhotoUrl": userProfilePhotoUrl,
      "username": username,
      "imageUrl": imageUrl,
      "caption": caption,
      "userId": userId,
    };
  }
}
