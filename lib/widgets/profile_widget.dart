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
    required this.loading,
  });

  final double height;
  final double width;
  final bool wantBorder;
  final bool photoSelected;
  final bool editProfileImage;
  final UserData userData;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    print(userData.profilePhotoUrl);
    return Container(
      decoration: wantBorder
          ? BoxDecoration(
              border: (editProfileImage && photoSelected)
                  ? null
                  : Border.all(
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
          ? ClipOval(
              child: Container(
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: CachedNetworkImage(
                  fit: BoxFit.fill,
                  imageUrl: userData.profilePhotoUrl,
                ),
              ),
            )
          : loading
              ? const Center(
                  child: CircularProgressIndicator(
                  strokeWidth: 1,
                  color: Colors.white,
                ))
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
