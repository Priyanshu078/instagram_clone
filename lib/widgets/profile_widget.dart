import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/constants/colors.dart';
import 'package:instagram_clone/data/user_data.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({
    super.key,
    required this.height,
    required this.width,
    required this.wantBorder,
    required this.photoSelected,
    required this.editProfileImage,
    required this.userData,
  });

  final double height;
  final double width;
  final bool wantBorder;
  final bool photoSelected;
  final bool editProfileImage;
  final UserData userData;

  @override
  Widget build(BuildContext context) {
    print(userData.profilePhotoUrl);
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
          ? Container(
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: CachedNetworkImage(
                fit: BoxFit.fill,
                imageUrl: userData.profilePhotoUrl,
              ),
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
