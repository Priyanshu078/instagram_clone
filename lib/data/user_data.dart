import 'package:instagram_clone/data/comment_data.dart';
import 'package:instagram_clone/data/posts_data.dart';
import 'package:instagram_clone/data/stories.dart';

class UserData {
  final String id;
  final String name;
  final String username;
  final String contact;
  final String password;
  final int gender;
  final String bio;
  final String tagline;
  final List<Story> stories;
  final List<Post> posts;
  final List followers;
  final List following;
  final String profilePhotoUrl;
  final bool private;
  final List bookmarks;
  final bool addedStory;
  final String fcmToken;

  UserData(
    this.id,
    this.name,
    this.username,
    this.contact,
    this.password,
    this.gender,
    this.bio,
    this.tagline,
    this.posts,
    this.stories,
    this.followers,
    this.following,
    this.profilePhotoUrl,
    this.private,
    this.bookmarks,
    this.addedStory,
    this.fcmToken,
  );

  factory UserData.temp() {
    return UserData("id", "name", "username", "contact", "password", 1, "bio",
        "tagline", [], [], [], [], "", false, [], false, "");
  }

  UserData copyWith({
    String? id,
    String? name,
    String? username,
    String? contact,
    String? password,
    int? gender,
    String? bio,
    String? tagline,
    List<Post>? posts,
    List<Story>? stories,
    List? followers,
    List? following,
    String? profilePhotoUrl,
    bool? private,
    List? bookmarks,
    bool? addedStory,
    String? fcmToken,
  }) {
    return UserData(
      id ?? this.id,
      name ?? this.name,
      username ?? this.username,
      contact ?? this.contact,
      password ?? this.password,
      gender ?? this.gender,
      bio ?? this.bio,
      tagline ?? this.tagline,
      posts ?? this.posts,
      stories ?? this.stories,
      followers ?? this.followers,
      following ?? this.following,
      profilePhotoUrl ?? this.profilePhotoUrl,
      private ?? this.private,
      bookmarks ?? this.bookmarks,
      addedStory ?? this.addedStory,
      fcmToken ?? this.fcmToken,
    );
  }

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      json['id'],
      json['name'],
      json['username'],
      json['contact'],
      json['password'],
      json['gender'],
      json['bio'],
      json['tagline'],
      List<Post>.from(
        json['posts'].map(
          (post) => Post(
              id: post['id'],
              username: post['username'],
              imageUrl: post['imageUrl'],
              likes: post['likes'],
              comments: List.from(post["comments"].map((comment) => Comments(
                    comment["comment"],
                    comment['profilePhotoUrl'],
                    comment['username'],
                    comment["userId"],
                    comment["id"],
                  ))),
              caption: post['caption'],
              userId: post['userId'],
              userProfilePhotoUrl: post['userProfilePhotoUrl']),
        ),
      ),
      List.from(
        json['stories'].map(
          (story) => Story(
            id: story['id'],
            userProfilePhotoUrl: story['userProfilePhotoUrl'],
            username: story['username'],
            imageUrl: story['imageUrl'],
            caption: story['caption'],
            userId: story['userId'],
            date: story['date'],
          ),
        ),
      ),
      json['followers'],
      json['following'],
      json['profilePhotoUrl'],
      json['private'],
      json['bookmarks'],
      json['addedStory'],
      json['fcmToken'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "username": username,
      "contact": contact,
      "password": password,
      "gender": gender,
      "bio": bio,
      "tagline": tagline,
      "stories": stories.map((e) => e.toJson()),
      "posts": posts.map((e) => e.toJson()),
      "followers": followers,
      "following": following,
      "profilePhotoUrl": profilePhotoUrl,
      "private": private,
      "bookmarks": bookmarks,
      "addedStory": addedStory,
      "fcmToken": fcmToken,
    };
  }
}
