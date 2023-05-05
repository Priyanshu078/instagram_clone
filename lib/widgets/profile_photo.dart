import 'package:flutter/material.dart';
import 'package:instagram_clone/constants/colors.dart';

class ProfilePhoto extends StatelessWidget {
  const ProfilePhoto(
      {super.key,
      required this.height,
      required this.width,
      required this.wantBorder,
      required this.storyAdder});

  final double height;
  final double width;
  final bool wantBorder;
  final bool storyAdder;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      height: height,
      width: width,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: wantBorder
            ? Border.all(
                color: profilePhotoBorder,
              )
            : null,
      ),
      child: storyAdder
          ? Center(
              child: Container(
                  padding: const EdgeInsets.all(18),
                  child: Image.asset(
                    'assets/images/add_Chat.png',
                  )),
            )
          : const CircleAvatar(
              backgroundImage: AssetImage('assets/images/priyanshuphoto.jpg'),
            ),
    );
  }
}
