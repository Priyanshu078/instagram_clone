import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/pages/homepage/bloc/homepage_bloc.dart';
import 'package:instagram_clone/pages/homepage/homepage_pages/feed/bloc/feed_bloc.dart';
import 'package:instagram_clone/widgets/instatext.dart';
import 'package:instagram_clone/widgets/profile_photo.dart';

import '../pages/homepage/homepage_pages/profile/bloc/profile_bloc.dart';
import '../pages/homepage/homepage_pages/search/bloc/search_bloc.dart';

class PostTile extends StatelessWidget {
  const PostTile({
    super.key,
    required this.width,
    required this.height,
    required this.profileState,
    required this.searchState,
    required this.index,
    required this.feedState,
    required this.optionPressed,
    required this.likePressed,
    required this.commentPressed,
    required this.bookmarkPressed,
    required this.sharePressed,
    required this.onDoubleTap,
  });

  final double width;
  final double height;
  final ProfileState? profileState;
  final SearchState? searchState;
  final FeedState? feedState;
  final int index;
  final VoidCallback optionPressed;
  final VoidCallback likePressed;
  final VoidCallback commentPressed;
  final VoidCallback bookmarkPressed;
  final VoidCallback sharePressed;
  final VoidCallback onDoubleTap;

  @override
  Widget build(BuildContext context) {
    var homePageBloc = context.read<HomepageBloc>();
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
                          imageUrl: searchState == null
                              ? profileState == null
                                  ? feedState!.posts[index].userProfilePhotoUrl
                                  : profileState!.userData.profilePhotoUrl
                              : searchState!.usersPosts
                                  ? searchState!.userData.profilePhotoUrl
                                  : searchState!
                                      .posts[index].userProfilePhotoUrl),
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
                        text: searchState == null
                            ? profileState == null
                                ? feedState!.posts[index].username
                                : profileState!.userData.username
                            : searchState!.usersPosts
                                ? searchState!.userData.username
                                : searchState!.posts[index].username,
                      ),
                    )
                  ],
                ),
                IconButton(
                  onPressed: optionPressed,
                  icon: const Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GestureDetector(
              onDoubleTap: onDoubleTap,
              child: CachedNetworkImage(
                imageUrl: searchState == null
                    ? profileState == null
                        ? feedState!.posts[index].imageUrl
                        : profileState!.userData.posts[index].imageUrl
                    : searchState!.usersPosts
                        ? searchState!.userData.posts[index].imageUrl
                        : searchState!.posts[index].imageUrl,
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
            child: SizedBox(
              height: height * 0.054,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: searchState != null
                            ? searchState!.usersPosts
                                ? searchState!.userData.posts[index].likes
                                        .contains(homePageBloc.sharedPreferences
                                            .getString("userId"))
                                    ? Image.asset(
                                        "assets/images/notification_red.png",
                                      )
                                    : Image.asset(
                                        "assets/images/notification.png",
                                      )
                                : searchState!.posts[index].likes.contains(
                                        homePageBloc.sharedPreferences
                                            .getString("userId"))
                                    ? Image.asset(
                                        "assets/images/notification_red.png",
                                      )
                                    : Image.asset(
                                        "assets/images/notification.png",
                                      )
                            : profileState != null
                                ? profileState!.userData.posts[index].likes
                                        .contains(homePageBloc.sharedPreferences
                                            .getString("userId"))
                                    ? Image.asset(
                                        "assets/images/notification_red.png",
                                      )
                                    : Image.asset(
                                        "assets/images/notification.png",
                                      )
                                : feedState != null
                                    ? feedState!.posts[index].likes.contains(
                                            homePageBloc.sharedPreferences
                                                .getString("userId"))
                                        ? Image.asset(
                                            "assets/images/notification_red.png",
                                          )
                                        : Image.asset(
                                            "assets/images/notification.png",
                                          )
                                    : Image.asset(
                                        "assets/images/notification.png",
                                      ),
                        onPressed: likePressed,
                      ),
                      IconButton(
                        icon: Image.asset(
                          "assets/images/insta_comment.png",
                        ),
                        onPressed: commentPressed,
                      ),
                      IconButton(
                        icon: Image.asset(
                          "assets/images/messanger.png",
                        ),
                        onPressed: sharePressed,
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: bookmarkPressed,
                    icon: feedState != null
                        ? feedState!.userData.bookmarks
                                .contains(feedState!.posts[index].id)
                            ? const Icon(
                                CupertinoIcons.bookmark_fill,
                                color: Colors.white,
                              )
                            : const Icon(
                                CupertinoIcons.bookmark,
                                color: Colors.white,
                              )
                        : const Icon(
                            CupertinoIcons.bookmark,
                            color: Colors.white,
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
                text: searchState == null
                    ? profileState == null
                        ? "${feedState!.posts[index].likes.length} likes"
                        : "${profileState!.userData.posts[index].likes.length} likes"
                    : searchState!.usersPosts
                        ? "${searchState!.userData.posts[index].likes.length} likes"
                        : "${searchState!.posts[index].likes.length} likes",
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
                    text: searchState == null
                        ? profileState == null
                            ? feedState!.posts[index].username
                            : profileState!.userData.username
                        : searchState!.usersPosts
                            ? searchState!.userData.username
                            : searchState!.posts[index].username,
                  ),
                  SizedBox(
                    width: width * 0.02,
                  ),
                  InstaText(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                    text: searchState == null
                        ? profileState == null
                            ? feedState!.posts[index].caption
                            : profileState!.userData.posts[index].caption
                        : searchState!.usersPosts
                            ? searchState!.userData.posts[index].caption
                            : searchState!.posts[index].caption,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
