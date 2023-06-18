import 'package:flutter/material.dart';
import 'package:instagram_clone/data/comment_data.dart';
import 'package:instagram_clone/widgets/instatext.dart';
import 'package:instagram_clone/widgets/profile_photo.dart';

class CommentList extends StatelessWidget {
  const CommentList({
    super.key,
    required this.comments,
    required this.tileHeight,
    required this.height,
    required this.width,
  });

  final List<Comments> comments;
  final double tileHeight;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: comments.length,
        itemBuilder: (context, index) {
          return SizedBox(
            height: tileHeight,
            width: double.infinity,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ProfilePhoto(
                        height: height * 0.06,
                        width: height * 0.065,
                        wantBorder: false,
                        storyAdder: false,
                        imageUrl: comments[index].profilePhotoUrl!,
                      ),
                      SizedBox(
                        width: width * 0.03,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InstaText(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              text: comments[index].username!),
                          InstaText(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              text: comments[index].comment!),
                        ],
                      ),
                    ],
                  ),
                  Container(),
                ]),
          );
        });
  }
}
