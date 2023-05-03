import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget(
      {super.key,
      required this.height,
      required this.width,
      required this.wantBorder});

  final double height;
  final double width;
  final bool wantBorder;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: wantBorder
          ? BoxDecoration(
              border: Border.all(color: Colors.white, width: 1.5),
              shape: BoxShape.circle)
          : null,
      height: height,
      width: width,
      child: const CircleAvatar(
        backgroundImage: AssetImage('assets/images/priyanshuphoto.jpg'),
      ),
    );
  }
}
