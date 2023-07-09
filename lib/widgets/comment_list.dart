import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/data/comment_data.dart';
import 'package:instagram_clone/pages/homepage/homepage_pages/feed/bloc/feed_bloc.dart';
import 'package:instagram_clone/pages/homepage/homepage_pages/profile/bloc/profile_bloc.dart';
import 'package:instagram_clone/pages/homepage/homepage_pages/search/bloc/search_bloc.dart';
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
    required this.feedComments,
    required this.searchComments,
    required this.profileComments,
    required this.postIndex,
    required this.inFeed,
  });

  final List<Comments> comments;
  final double tileHeight;
  final double height;
  final double width;
  final SharedPreferences sharedPreferences;
  final bool feedComments;
  final bool searchComments;
  final bool profileComments;
  final int postIndex;
  final bool inFeed;

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
                            if (feedComments) {
                              context.read<FeedBloc>().add(DeleteFeedComment(
                                    postIndex,
                                    index - 1,
                                    inFeed,
                                  ));
                            } else if (searchComments) {
                              context.read<SearchBloc>().add(
                                  DeleteSearchComment(postIndex, index - 1));
                            } else if (profileComments) {
                              context.read<ProfileBloc>().add(
                                  DeleteProfileComment(postIndex, index - 1));
                            }
                          },
                        ),
                ]),
          );
        });
  }
}
