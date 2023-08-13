import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/widgets/profile_photo.dart';

class NotificationTile extends StatelessWidget {
  const NotificationTile(
      {super.key,
      required this.profilePhotoUrl,
      required this.username,
      required this.date,
      required this.message,
      this.imageUrl,
      required this.height,
      required this.width});
  final String profilePhotoUrl;
  final String username;
  final String date;
  final String message;
  final String? imageUrl;
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(color: Colors.black),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ProfilePhoto(
                height: height * 0.8,
                width: width * 0.2,
                wantBorder: false,
                storyAdder: false,
                imageUrl: profilePhotoUrl),
            RichText(
              text: TextSpan(
                text: username,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
                children: <TextSpan>[
                  TextSpan(
                      text: message,
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.normal)),
                  TextSpan(
                      text: date,
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.normal)),
                ],
              ),
            ),
            SizedBox(
                height: height * 0.8,
                width: width * 0.2,
                child: CachedNetworkImage(imageUrl: imageUrl!))
          ],
        ));
  }
}
