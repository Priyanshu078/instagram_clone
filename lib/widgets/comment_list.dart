import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/data/comment_data.dart';
import 'package:instagram_clone/pages/homepage/bloc/homepage_bloc.dart';
import 'package:instagram_clone/pages/homepage/homepage_pages/feed/bloc/feed_bloc.dart';
import 'package:instagram_clone/widgets/instatext.dart';
import 'package:instagram_clone/widgets/profile_photo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommentList extends StatelessWidget {
  const CommentList({
    super.key,
    required this.comments,
    required this.tileHeight,
    required this.height,
    required this.width,
    required this.sharedPreferences,
    required this.feed,
    required this.search,
    required this.profile,
    required this.postIndex,
  });

  final List<Comments> comments;
  final double tileHeight;
  final double height;
  final double width;
  final SharedPreferences sharedPreferences;
  final bool feed;
  final bool search;
  final bool profile;
  final int postIndex;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: comments.length,
        itemBuilder: (context, index) {
          return SizedBox(
            height: tileHeight,
            width: double.infinity,
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
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
                  index == 0 ||
                          (comments[index].userId !=
                              sharedPreferences.getString('userId'))
                      ? Container()
                      : IconButton(
                          icon: const Icon(
                            Icons.delete_outline,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            if (feed) {
                              context
                                  .read<FeedBloc>()
                                  .add(DeleteFeedComment(postIndex, index - 1));
                            } else if (search) {
                            } else if (profile) {}
                          },
                        ),
                ]),
          );
        });
  }
}
