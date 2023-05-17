import 'package:instagram_clone/pages/authentication/auth_pages/signup_page.dart';

class UserData {
  final String id;
  final String name;
  final String username;
  final String contact;
  final String password;
  final int gender;

  UserData(this.id, this.name, this.username, this.contact, this.password,
      this.gender);

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(json['id'], json['name'], json['username'], json['contact'],
        json['password'], json['gender']);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "username": username,
      "contact": contact,
      "password": password,
      "gender": gender,
    };
  }
}
