import 'package:flutter/material.dart';
import 'package:instagram_clone/constants/colors.dart';
import 'package:instagram_clone/widgets/insta_button.dart';
import 'package:instagram_clone/widgets/instatext.dart';
import 'package:instagram_clone/widgets/profile_photo.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: textFieldBackgroundColor,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 12.0, right: 12.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ProfilePhoto(
                        height: height * 0.13,
                        width: height * 0.13,
                        wantBorder: true),
                    SizedBox(
                      width: width * 0.1,
                    ),
                    Row(
                      children: [
                        Column(
                          children: const [
                            InstaText(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                text: "1"),
                            InstaText(
                                fontSize: 13,
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                                text: "Posts")
                          ],
                        ),
                        SizedBox(
                          width: width * 0.05,
                        ),
                        Column(
                          children: const [
                            InstaText(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                text: "1"),
                            InstaText(
                                fontSize: 13,
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                                text: "Followers")
                          ],
                        ),
                        SizedBox(
                          width: width * 0.05,
                        ),
                        Column(
                          children: const [
                            InstaText(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                text: "1"),
                            InstaText(
                                fontSize: 13,
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                                text: "Following")
                          ],
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: height * 0.015,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const InstaText(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          text: "Priyanshu Paliwal"),
                      SizedBox(
                        height: height * 0.003,
                      ),
                      const InstaText(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          text:
                              "Flutter Developer, Public Speaker, Multi Billionare"),
                      SizedBox(
                        height: height * 0.003,
                      ),
                      const InstaText(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          text: "Love Yourself"),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.015,
                ),
                InstaButton(
                    buttonColor: Colors.black,
                    onPressed: () {},
                    text: "Edit Profile",
                    fontSize: 13,
                    textColor: Colors.white,
                    fontWeight: FontWeight.w700)
              ],
            ),
          )
        ],
      ),
    );
  }
}
