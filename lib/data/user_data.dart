import 'package:instagram_clone/pages/authentication/auth_pages/signup_page.dart';

class UserData {
  final String id;
  final String name;
  final String username;
  final String phoneNumber;
  final String email;
  final String password;
  final Gender gender;

  UserData(this.id, this.name, this.username, this.phoneNumber, this.email,
      this.password, this.gender);

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(json['id'], json['name'], json['username'],
        json['phoneNumber'], json['email'], json['password'], json['gender']);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "username": username,
      "phoneNumber": phoneNumber,
      "email": email,
      "password": password,
      "gender": gender,
    };
  }
}
