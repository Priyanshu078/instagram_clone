import 'package:flutter/material.dart';
import 'package:instagram_clone/widgets/instatext.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: InstaText(
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.w500,
            text: "Profile"),
      ),
    );
  }
}
