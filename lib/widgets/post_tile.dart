import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/widgets/instatext.dart';
import 'package:instagram_clone/widgets/profile_photo.dart';

class PostTile extends StatelessWidget {
  const PostTile(
      {super.key,
      required this.width,
      required this.height,
      required this.state,
      required this.index});

  final double width;
  final double height;
  final dynamic state;
  final int index;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height - 2.5 * (AppBar().preferredSize.height),
      width: width,
      child: Column(
        children: [
          SizedBox(
            height: AppBar().preferredSize.height,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: ProfilePhoto(
                        height: height * 0.06,
                        width: height * 0.065,
                        wantBorder: false,
                        storyAdder: false,
                        imageUrl: state.userdata.profilePhotoUrl,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.02,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: InstaText(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        text: state.userdata.username,
                      ),
                    )
                  ],
                ),
                const SizedBox(),
              ],
            ),
          ),
          Expanded(
            child: CachedNetworkImage(
              imageUrl: state.userdata.posts[index].imageUrl,
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: height * 0.054,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Image.asset(
                          "assets/images/notification.png",
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Image.asset(
                          "assets/images/insta_comment.png",
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Image.asset(
                          "assets/images/messanger.png",
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                      "assets/images/insta_bookmark.png",
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: InstaText(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w700,
                text: "${state.userdata.posts[index].likes} likes",
              ),
            ),
          ),
          SizedBox(
            height: height * 0.005,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  InstaText(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    text: state.userdata.username,
                  ),
                  SizedBox(
                    width: width * 0.02,
                  ),
                  InstaText(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                    text: state.userdata.posts[index].caption,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
    ;
  }
}
