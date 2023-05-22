import 'package:flutter/material.dart';
import 'package:instagram_clone/constants/colors.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({
    super.key,
    required this.height,
    required this.width,
    required this.wantBorder,
    required this.photoSelected,
    required this.editProfileImage,
  });

  final double height;
  final double width;
  final bool wantBorder;
  final bool photoSelected;
  final bool editProfileImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: wantBorder
          ? BoxDecoration(
              border: Border.all(
                  color: editProfileImage
                      ? profilePhotoBorder
                      : photoSelected
                          ? Colors.white
                          : searchHintText,
                  width: 1.5),
              shape: BoxShape.circle)
          : null,
      height: height,
      width: width,
      child: photoSelected
          ? const CircleAvatar(
              backgroundImage: AssetImage('assets/images/priyanshuphoto.jpg'),
            )
          : Center(
              child: Icon(
                Icons.person,
                color: searchHintText,
                size: height * 0.3,
              ),
            ),
    );
  }
}
