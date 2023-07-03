import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/data/stories.dart';
import 'package:instagram_clone/widgets/instatext.dart';
import 'package:instagram_clone/widgets/profile_photo.dart';

class ViewStoryPage extends StatelessWidget {
  const ViewStoryPage({super.key, required this.story});

  final Story story;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    ProfilePhoto(
                      height: height * 0.06,
                      width: height * 0.065,
                      wantBorder: false,
                      storyAdder: false,
                      imageUrl: story.userProfilePhotoUrl,
                    ),
                    SizedBox(
                      width: width * 0.02,
                    ),
                    InstaText(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      text: story.username,
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                width: double.infinity,
                imageUrl: story.imageUrl,
                fit: BoxFit.fill,
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
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InstaText(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.w600,
                text: story.caption),
          ),
        ]),
      ),
    );
  }
}
