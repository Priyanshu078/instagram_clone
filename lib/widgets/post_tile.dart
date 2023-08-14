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
    required this.onUserNamePressed,
    required this.isFeedData,
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
  final VoidCallback onUserNamePressed;
  final bool isFeedData;

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
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                  ? isFeedData
                                      ? feedState!
                                          .posts[index].userProfilePhotoUrl
                                      : feedState!.userData.posts[index]
                                          .userProfilePhotoUrl
                                  : profileState!.savedPosts
                                      ? profileState!.savedPostsList[index]
                                          .userProfilePhotoUrl
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
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: GestureDetector(
                        onTap: onUserNamePressed,
                        child: InstaText(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          text: searchState == null
                              ? profileState == null
                                  ? isFeedData
                                      ? feedState!.posts[index].username
                                      : feedState!
                                          .userData.posts[index].username
                                  : profileState!.savedPosts
                                      ? profileState!
                                          .savedPostsList[index].username
                                      : profileState!.userData.username
                              : searchState!.usersPosts
                                  ? searchState!.userData.username
                                  : searchState!.posts[index].username,
                        ),
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
                width: double.infinity,
                imageUrl: searchState == null
                    ? profileState == null
                        ? isFeedData
                            ? feedState!.posts[index].imageUrl
                            : feedState!.userData.posts[index].imageUrl
                        : profileState!.savedPosts
                            ? profileState!.savedPostsList[index].imageUrl
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
                                : searchState!.posts[index].likes.contains(homePageBloc.sharedPreferences
                                        .getString("userId"))
                                    ? Image.asset(
                                        "assets/images/notification_red.png",
                                      )
                                    : Image.asset(
                                        "assets/images/notification.png",
                                      )
                            : profileState != null
                                ? profileState!.savedPosts
                                    ? profileState!.savedPostsList[index].likes
                                            .contains(homePageBloc.sharedPreferences
                                                .getString("userId"))
                                        ? Image.asset(
                                            "assets/images/notification_red.png",
                                          )
                                        : Image.asset(
                                            "assets/images/notification.png",
                                          )
                                    : profileState!.userData.posts[index].likes
                                            .contains(homePageBloc.sharedPreferences
                                                .getString("userId"))
                                        ? Image.asset(
                                            "assets/images/notification_red.png",
                                          )
                                        : Image.asset(
                                            "assets/images/notification.png",
                                          )
                                : feedState != null
                                    ? (isFeedData
                                            ? feedState!.posts[index].likes.contains(homePageBloc.sharedPreferences.getString("userId"))
                                            : feedState!.userData.posts[index].likes.contains(homePageBloc.sharedPreferences.getString("userId")))
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
                        ? (isFeedData
                                ? feedState!.myData.bookmarks
                                    .contains(feedState!.posts[index].id)
                                : feedState!.myData.bookmarks.contains(
                                    feedState!.userData.posts[index].id))
                            ? const Icon(
                                CupertinoIcons.bookmark_fill,
                                color: Colors.white,
                              )
                            : const Icon(
                                CupertinoIcons.bookmark,
                                color: Colors.white,
                              )
                        : profileState != null
                            ? profileState!.savedPosts
                                ? profileState!.userData.bookmarks.contains(
                                        profileState!.savedPostsList[index].id)
                                    ? const Icon(
                                        CupertinoIcons.bookmark_fill,
                                        color: Colors.white,
                                      )
                                    : const Icon(
                                        CupertinoIcons.bookmark,
                                        color: Colors.white,
                                      )
                                : profileState!.userData.bookmarks.contains(
                                        profileState!.userData.posts[index].id)
                                    ? const Icon(
                                        CupertinoIcons.bookmark_fill,
                                        color: Colors.white,
                                      )
                                    : const Icon(
                                        CupertinoIcons.bookmark,
                                        color: Colors.white,
                                      )
                            : searchState != null
                                ? searchState!.myData.bookmarks.contains(
                                        searchState!.usersPosts
                                            ? searchState!
                                                .userData.posts[index].id
                                            : searchState!.posts[index].id)
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
                        ? isFeedData
                            ? "${feedState!.posts[index].likes.length} likes"
                            : "${feedState!.userData.posts[index].likes.length} likes"
                        : profileState!.savedPosts
                            ? "${profileState!.savedPostsList[index].likes.length} likes"
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
                            ? isFeedData
                                ? feedState!.posts[index].username
                                : feedState!.userData.posts[index].username
                            : profileState!.savedPosts
                                ? profileState!.savedPostsList[index].username
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
                            ? isFeedData
                                ? feedState!.posts[index].caption
                                : feedState!.userData.posts[index].caption
                            : profileState!.savedPosts
                                ? profileState!.savedPostsList[index].caption
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
