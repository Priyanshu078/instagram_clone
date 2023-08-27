import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:instagram_clone/pages/homepage/homepage_pages/feed/bloc/feed_bloc.dart';
import 'package:instagram_clone/pages/homepage/homepage_pages/profile/bloc/profile_bloc.dart';
import 'package:instagram_clone/pages/homepage/homepage_pages/search/bloc/search_bloc.dart';
import 'package:instagram_clone/pages/homepage/homepage_pages/feed/comment_page.dart';
import 'package:instagram_clone/widgets/instatext.dart';
import 'package:instagram_clone/widgets/post_tile.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/colors.dart';

class UserPosts extends StatefulWidget {
  const UserPosts({
    super.key,
    required this.inProfile,
    required this.inFeed,
  });
  final bool inProfile;
  final bool inFeed;

  @override
  State<UserPosts> createState() => _UserPostsState();
}

class _UserPostsState extends State<UserPosts> {
  Widget buildBottomSheet(
    BuildContext context,
    double height,
    double width,
    bool inProfile,
    bool userPosts,
    int index,
    SearchState? searchState,
    ProfileState? profileState,
    FeedState? feedState,
  ) {
    return SizedBox(
      height: height * 0.3,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 16.0,
          bottom: 16.0,
        ),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                if (feedState != null) {
                  context.read<FeedBloc>().add(BookmarkFeed(index, false));
                } else if (profileState != null) {
                  context.read<ProfileBloc>().add(BookmarkProfile(index));
                } else {
                  context.read<SearchBloc>().add(BookmarkSearch(index));
                }
                Navigator.of(context).pop();
              },
              child: Column(
                children: [
                  Container(
                    height: height * 0.09,
                    width: height * 0.09,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 1,
                      ),
                    ),
                    child: Center(
                        child: feedState != null
                            ? feedState.myData.bookmarks.contains(
                                    feedState.userData.posts[index].id)
                                ? const Icon(
                                    CupertinoIcons.bookmark_fill,
                                    color: Colors.white,
                                    size: 30,
                                  )
                                : const Icon(
                                    CupertinoIcons.bookmark,
                                    color: Colors.white,
                                    size: 30,
                                  )
                            : profileState != null
                                ? profileState.userData.bookmarks.contains(
                                        profileState.userData.posts[index].id)
                                    ? const Icon(
                                        CupertinoIcons.bookmark_fill,
                                        color: Colors.white,
                                        size: 30,
                                      )
                                    : const Icon(
                                        CupertinoIcons.bookmark,
                                        color: Colors.white,
                                        size: 30,
                                      )
                                : searchState!.myData.bookmarks.contains(
                                        searchState.usersPosts
                                            ? searchState
                                                .userData.posts[index].id
                                            : searchState.posts[index].id)
                                    ? const Icon(
                                        CupertinoIcons.bookmark_fill,
                                        color: Colors.white,
                                        size: 30,
                                      )
                                    : const Icon(
                                        CupertinoIcons.bookmark,
                                        color: Colors.white,
                                        size: 30,
                                      )),
                  ),
                  const SizedBox(
                    height: 4.0,
                  ),
                  const InstaText(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                    text: "Save",
                  )
                ],
              ),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Divider(
              color: Colors.white.withOpacity(0.3),
            ),
            (inProfile || userPosts)
                ? ListTile(
                    minLeadingWidth: 0,
                    leading: Icon(
                      Icons.delete_outline,
                      color: instaRed,
                    ),
                    title: InstaText(
                      fontSize: 17,
                      color: instaRed,
                      fontWeight: FontWeight.normal,
                      text: "Delete",
                    ),
                    onTap: () {
                      if (profileState != null) {
                        context.read<ProfileBloc>().add(DeletePost(index));
                      } else {
                        if (searchState!.usersPosts) {
                          context
                              .read<SearchBloc>()
                              .add(DeleteSearchProfilePost(index));
                        }
                      }
                      Navigator.of(context).pop();
                    },
                  )
                : ListTile(
                    minLeadingWidth: 0,
                    leading: searchState!.myData.following
                            .contains(searchState.posts[index].userId)
                        ? const Icon(
                            Icons.person_remove,
                            color: Colors.white,
                          )
                        : const Icon(
                            Icons.person_add,
                            color: Colors.white,
                          ),
                    title: InstaText(
                      fontSize: 17,
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      text: searchState.myData.following
                              .contains(searchState.posts[index].userId)
                          ? "Unfollow"
                          : "follow",
                    ),
                    onTap: () {
                      if (searchState.myData.following
                          .contains(searchState.posts[index].userId)) {
                        context.read<SearchBloc>().add(UnFollowSearchEvent(
                            fromProfile: false, index: index));
                      } else {
                        context.read<SearchBloc>().add(FollowSearchEvent(
                            fromProfile: false, index: index));
                      }
                      Navigator.of(context).pop();
                    },
                  ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () async {
            if (widget.inFeed) {
              var bloc = context.read<FeedBloc>();
              bloc.pageController.jumpToPage(1);
            } else {
              if (widget.inProfile) {
                var bloc = context.read<ProfileBloc>();
                bloc.pageController.jumpToPage(0);
              } else {
                var bloc = context.read<SearchBloc>();
                if (bloc.state.usersPosts) {
                  bloc.pageController.jumpToPage(0);
                } else {
                  bloc.pageController.jumpToPage(1);
                }
              }
            }
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: InstaText(
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.w700,
          text: widget.inProfile && context.read<ProfileBloc>().state.savedPosts
              ? "Saved"
              : (widget.inProfile ||
                      context.read<SearchBloc>().state.usersPosts ||
                      widget.inFeed)
                  ? "Posts"
                  : "Explore",
        ),
      ),
      body: widget.inFeed
          ? BlocBuilder<FeedBloc, FeedState>(
              builder: (context, state) {
                return ScrollablePositionedList.builder(
                  initialScrollIndex: state.postsIndex,
                  itemCount: state.userData.posts.length,
                  itemBuilder: (context, index) {
                    return PostTile(
                      isFeedData: false,
                      width: width,
                      height: height,
                      profileState: null,
                      searchState: null,
                      index: index,
                      feedState: state,
                      optionPressed: () {
                        showModalBottomSheet(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            backgroundColor: textFieldBackgroundColor,
                            context: context,
                            builder: (_) => BlocProvider.value(
                                  value: context.read<ProfileBloc>(),
                                  child: buildBottomSheet(
                                      context,
                                      height,
                                      width,
                                      widget.inProfile,
                                      false,
                                      index,
                                      null,
                                      null,
                                      state),
                                ));
                      },
                      likePressed: () {
                        context.read<FeedBloc>().add(PostLikeEvent(
                              state.userData.posts[index].id,
                              index,
                              state.userData.posts[index].userId,
                              false,
                            ));
                      },
                      onDoubleTap: () {
                        context.read<FeedBloc>().add(PostLikeEvent(
                              state.userData.posts[index].id,
                              index,
                              state.userData.posts[index].userId,
                              false,
                            ));
                      },
                      commentPressed: () async {
                        var sharedPreferences =
                            await SharedPreferences.getInstance();
                        if (mounted) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => BlocProvider.value(
                                    value: context.read<FeedBloc>(),
                                    child: CommentPage(
                                      sharedPreferences: sharedPreferences,
                                      postIndex: index,
                                      profileState: null,
                                      searchState: null,
                                      feedState: state,
                                      inFeed: false,
                                    ),
                                  )));
                        }
                      },
                      bookmarkPressed: () {
                        context
                            .read<FeedBloc>()
                            .add(BookmarkFeed(index, false));
                      },
                      sharePressed: () async {
                        context.read<FeedBloc>().add(ShareFileEvent(
                            caption: state.userData.posts[index].caption,
                            imageUrl: state.userData.posts[index].imageUrl));
                        await Fluttertoast.showToast(
                            msg: "Please wait !!!",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.white,
                            textColor: Colors.black,
                            fontSize: 14.0);
                      },
                      onUserNamePressed: () {},
                    );
                  },
                );
              },
            )
          : widget.inProfile
              ? BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, state) {
                    if (state is ProfileLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 1,
                          color: Colors.white,
                        ),
                      );
                    } else {
                      return ScrollablePositionedList.builder(
                        initialScrollIndex:
                            state.savedPosts ? 0 : state.postsIndex,
                        itemCount: state.savedPosts
                            ? state.savedPostsList.length
                            : state.userData.posts.length,
                        itemBuilder: (context, index) {
                          return PostTile(
                            isFeedData: false,
                            width: width,
                            height: height,
                            profileState: state,
                            searchState: null,
                            index: index,
                            feedState: null,
                            optionPressed: () {
                              showModalBottomSheet(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  backgroundColor: textFieldBackgroundColor,
                                  context: context,
                                  builder: (_) => BlocProvider.value(
                                        value: context.read<ProfileBloc>(),
                                        child: buildBottomSheet(
                                          context,
                                          height,
                                          width,
                                          widget.inProfile,
                                          false,
                                          index,
                                          null,
                                          state,
                                          null,
                                        ),
                                      ));
                            },
                            likePressed: () {
                              context
                                  .read<ProfileBloc>()
                                  .add(LikePostEvent(index));
                            },
                            onDoubleTap: () {
                              context
                                  .read<ProfileBloc>()
                                  .add(LikePostEvent(index));
                            },
                            commentPressed: () async {
                              var sharedPreferences =
                                  await SharedPreferences.getInstance();
                              if (mounted) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => BlocProvider.value(
                                          value: context.read<ProfileBloc>(),
                                          child: CommentPage(
                                            sharedPreferences:
                                                sharedPreferences,
                                            postIndex: index,
                                            profileState: state,
                                            searchState: null,
                                            feedState: null,
                                            inFeed: false,
                                          ),
                                        )));
                              }
                            },
                            bookmarkPressed: () {
                              context
                                  .read<ProfileBloc>()
                                  .add(BookmarkProfile(index));
                            },
                            sharePressed: () async {
                              context.read<ProfileBloc>().add(
                                  ShareProfileFileEvent(
                                      imageUrl:
                                          state.savedPosts
                                              ? state.savedPostsList[index]
                                                  .imageUrl
                                              : state.userData.posts[index]
                                                  .imageUrl,
                                      caption: state.savedPosts
                                          ? state.savedPostsList[index].caption
                                          : state
                                              .userData.posts[index].caption));
                              await Fluttertoast.showToast(
                                  msg: "Please wait !!!",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.white,
                                  textColor: Colors.black,
                                  fontSize: 14.0);
                            },
                            onUserNamePressed: () {},
                          );
                        },
                      );
                    }
                  },
                )
              : BlocBuilder<SearchBloc, SearchState>(
                  builder: (context, state) {
                    return ScrollablePositionedList.builder(
                      initialScrollIndex: state.postsIndex,
                      itemCount: state.usersPosts
                          ? state.userData.posts.length
                          : state.posts.length,
                      itemBuilder: (context, index) {
                        return PostTile(
                          isFeedData: false,
                          width: width,
                          height: height,
                          profileState: null,
                          searchState: state,
                          index: index,
                          feedState: null,
                          optionPressed: () {
                            showModalBottomSheet(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                backgroundColor: textFieldBackgroundColor,
                                context: context,
                                builder: (_) => BlocProvider.value(
                                      value: context.read<SearchBloc>(),
                                      child: buildBottomSheet(
                                          context,
                                          height,
                                          width,
                                          widget.inProfile,
                                          state.usersPosts,
                                          index,
                                          state,
                                          null,
                                          null),
                                    ));
                          },
                          likePressed: () {
                            context.read<SearchBloc>().add(SearchLikePostEvent(
                                index,
                                state.usersPosts,
                                state.usersPosts
                                    ? state.userData.id
                                    : state.posts[index].userId,
                                state.usersPosts
                                    ? state.userData.posts[index].id
                                    : state.posts[index].id));
                          },
                          commentPressed: () async {
                            var sharedPreferences =
                                await SharedPreferences.getInstance();
                            if (mounted) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => BlocProvider.value(
                                        value: context.read<SearchBloc>(),
                                        child: CommentPage(
                                          sharedPreferences: sharedPreferences,
                                          postIndex: index,
                                          searchState: state,
                                          profileState: null,
                                          feedState: null,
                                          inFeed: false,
                                        ),
                                      )));
                            }
                          },
                          bookmarkPressed: () {
                            context
                                .read<SearchBloc>()
                                .add(BookmarkSearch(index));
                          },
                          sharePressed: () async {
                            context.read<SearchBloc>().add(ShareSearchFileEvent(
                                caption: state.usersPosts
                                    ? state.userData.posts[index].caption
                                    : state.posts[index].caption,
                                imageUrl: state.usersPosts
                                    ? state.userData.posts[index].imageUrl
                                    : state.posts[index].imageUrl));
                            await Fluttertoast.showToast(
                                msg: "Please wait !!!",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.white,
                                textColor: Colors.black,
                                fontSize: 14.0);
                          },
                          onDoubleTap: () {
                            context.read<SearchBloc>().add(SearchLikePostEvent(
                                index,
                                state.usersPosts,
                                state.usersPosts
                                    ? state.userData.id
                                    : state.posts[index].userId,
                                state.usersPosts
                                    ? state.userData.posts[index].id
                                    : state.posts[index].id));
                          },
                          onUserNamePressed: () async {
                            if (!state.usersPosts) {
                              var bloc = context.read<SearchBloc>();
                              bloc.add(FetchUserDataInSearch(
                                  userId: state.posts[index].userId));
                              await bloc.pageController.animateToPage(0,
                                  duration: const Duration(milliseconds: 200),
                                  curve: Curves.easeIn);
                            }
                          },
                        );
                      },
                    );
                  },
                ),
    );
  }
}
