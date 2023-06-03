import 'package:instagram_clone/data/posts_data.dart';

class UserData {
  final String id;
  final String name;
  final String username;
  final String contact;
  final String password;
  final int gender;
  final String bio;
  final String tagline;
  final List<dynamic> stories;
  final List<Post> posts;
  final int followers;
  final int following;
  final String profilePhotoUrl;

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
  );

  factory UserData.temp() {
    return UserData("id", "name", "username", "contact", "password", 1, "bio",
        "tagline", [], [], 0, 0, "");
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
    List? stories,
    int? followers,
    int? following,
    String? profilePhotoUrl,
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
            username: post['username'],
            imageUrl: post['imageUrl'],
            likes: post['likes'],
            comments: post['comments'],
            caption: post['caption'],
            userId: post['userId'],
          ),
        ),
      ),
      json['stories'],
      json['followers'],
      json['following'],
      json['profilePhotoUrl'],
    );
  }

  // List<Post> getPosts(List<dynamic> posts) {
  //   List<Post> postsList = [];
  //   for (int i = 0; i < posts.length; i++) {
  //     postsList.add(
  //       Post(
  //         username: posts[i]['username'],
  //         imageUrl: posts[i]['imageUrl'],
  //         likes: posts[i]['likes'],
  //         comments: posts[i]['comments'],
  //         caption: posts[i]['caption'],
  //       ),
  //     );
  //   }
  //   return postsList;
  // }

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
      "stories": stories,
      "posts": posts,
      "followers": followers,
      "following": following,
      "profilePhotoUrl": profilePhotoUrl,
    };
  }
}
