import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/constants/colors.dart';

class ProfilePhoto extends StatelessWidget {
  const ProfilePhoto({
    super.key,
    required this.height,
    required this.width,
    required this.wantBorder,
    required this.storyAdder,
    required this.imageUrl,
  });

  final double height;
  final double width;
  final bool wantBorder;
  final bool storyAdder;
  final String imageUrl;

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
                ),
              ),
            )
          : imageUrl != ""
              ? ClipOval(
                  child: Container(
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: CachedNetworkImage(
                      height: 340,
                      width: 340,
                      fit: BoxFit.fill,
                      imageUrl: imageUrl,
                      placeholder: (context, val) {
                        return const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 1,
                            color: Colors.white,
                          ),
                        );
                      },
                    ),
                  ),
                )
              : const CircleAvatar(
                  child: Icon(Icons.person),
                ),
    );
  }
}
