import 'package:flutter/material.dart';
import 'package:instagram_clone/constants/colors.dart';
import 'package:instagram_clone/widgets/instatext.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leadingWidth: width * 0.2,
        backgroundColor: Colors.black,
        leading: Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            child: TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.black),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const InstaText(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                  text: "Cancel"),
            ),
          ),
        ),
        centerTitle: true,
        title: const InstaText(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.w700,
            text: "Edit Profile"),
        actions: [
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.black),
              onPressed: () {},
              child: const InstaText(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  text: "Done"),
            ),
          )
        ],
      ),
    );
  }
}
