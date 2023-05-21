import 'package:flutter/material.dart';
import 'package:instagram_clone/constants/colors.dart';
import 'package:instagram_clone/widgets/instatext.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          elevation: 0,
          backgroundColor: textFieldBackgroundColor,
          title: SizedBox(
            height: AppBar().preferredSize.height * 0.8,
            width: width * 0.3,
            child: Image.asset('assets/images/instagram.png'),
          )),
      body: const Center(
        child: InstaText(
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.w500,
            text: "Notification"),
      ),
    );
  }
}
