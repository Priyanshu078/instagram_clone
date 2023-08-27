import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:instagram_clone/constants/colors.dart';
import 'package:instagram_clone/pages/homepage/bloc/homepage_bloc.dart';
import 'package:instagram_clone/pages/homepage/homepage_pages/feed/comment_page.dart';
import 'package:instagram_clone/pages/homepage/homepage_pages/feed/story/add_story.dart';
import 'package:instagram_clone/pages/homepage/homepage_pages/feed/story/bloc/story_bloc.dart';
import 'package:instagram_clone/pages/homepage/homepage_pages/feed/story/view_story.dart';
import 'package:instagram_clone/pages/homepage/homepage_pages/profile/bloc/profile_bloc.dart';
import 'package:instagram_clone/pages/homepage/homepage_pages/search/bloc/search_bloc.dart';
import 'package:instagram_clone/pages/homepage/homepage_pages/search/user_profile.dart';
import 'package:instagram_clone/widgets/instatext.dart';
import 'package:instagram_clone/widgets/post_tile.dart';
import 'package:instagram_clone/widgets/profile_photo.dart';
import 'package:instagram_clone/widgets/user_posts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bloc/feed_bloc.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  Widget buildBottomSheet(
      BuildContext context, double height, double width, int index) {
    var feedState = context.read<FeedBloc>().state;
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
                context.read<FeedBloc>().add(BookmarkFeed(index, true));
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
                      child: feedState.myData.bookmarks
                              .contains(feedState.posts[index].id)
                          ? const Icon(
                              CupertinoIcons.bookmark_fill,
                              color: Colors.white,
                              size: 30,
                            )
                          : const Icon(
                              CupertinoIcons.bookmark,
                              color: Colors.white,
                              size: 30,
                            ),
                    ),
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
            ListTile(
              minLeadingWidth: 0,
              leading: feedState.myData.following
                      .contains(feedState.posts[index].userId)
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
                text: feedState.myData.following
                        .contains(feedState.posts[index].userId)
                    ? "Unfollow"
                    : "follow",
              ),
              onTap: () {
                if (feedState.myData.following
                    .contains(feedState.posts[index].userId)) {
                  context
                      .read<FeedBloc>()
                      .add(UnFollowFeedEvent(fromFeed: true, index: index));
                } else {
                  context
                      .read<FeedBloc>()
                      .add(FollowFeedEvent(fromFeed: true, index: index));
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
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: context.read<FeedBloc>().pageController,
      children: [
        Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: textFieldBackgroundColor,
            title: SizedBox(
              height: AppBar().preferredSize.height * 0.8,
              width: width * 0.3,
              child: Image.asset('assets/images/instagram.png'),
            ),
            // actions: [
            //   IconButton(
            //     onPressed: () {},
            //     icon: SizedBox(
            //       height: AppBar().preferredSize.height * 0.8,
            //       width: width * 0.07,
            //       child: Image.asset('assets/images/messanger.png'),
            //     ),
            //   ),
            // ],
          ),
          body: BlocBuilder<FeedBloc, FeedState>(
            builder: (context, state) {
              if (state is FeedFetched ||
                  state is PostLikedState ||
                  state is CommentAddedState ||
                  state is CommentDeletedState ||
                  state is BookmarkedState ||
                  state is UserDataLoadingState ||
                  state is UserDataFetchedState ||
                  state is TabChangedFeedState ||
                  state is PostIndexChangeFeedState ||
                  state is MyStoryFetchedState ||
                  state is MyStoryDeletedState ||
                  state is FollowingFeedState ||
                  state is FollowedUserFeedState ||
                  state is UnFollowedUserFeedState ||
                  state is UnFollowingFeedState ||
                  state is StoryViewedState) {
                return ListView.builder(
                    itemCount: state.posts.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Row(
                            children: [
                              SizedBox(
                                height: height * 0.11,
                                width: width * 0.2,
                                child: GestureDetector(
                                  onTap: () {
                                    if (state.myData.addedStory) {
                                      context.read<FeedBloc>().add(
                                          const StoryViewEvent(
                                              viewMyStory: true));
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (_) => MultiBlocProvider(
                                                    providers: [
                                                      BlocProvider.value(
                                                          value: context.read<
                                                              HomepageBloc>()),
                                                      BlocProvider(
                                                        create: (context) =>
                                                            StoryBloc(),
                                                      ),
                                                      BlocProvider.value(
                                                        value: context
                                                            .read<FeedBloc>(),
                                                      ),
                                                      BlocProvider(
                                                          create: (context) =>
                                                              ProfileBloc(
                                                                  PageController())),
                                                      BlocProvider(
                                                          create: (context) =>
                                                              SearchBloc(
                                                                  PageController(),
                                                                  FocusNode(),
                                                                  TextEditingController()))
                                                    ],
                                                    child: ViewStoryPage(
                                                      story:
                                                          state.myStory.story,
                                                      inProfile: false,
                                                      index: index,
                                                      inSearchProfile: false,
                                                    ),
                                                  )));
                                    } else {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (_) => MultiBlocProvider(
                                                      providers: [
                                                        BlocProvider(
                                                            create: (context) =>
                                                                StoryBloc()),
                                                        BlocProvider.value(
                                                          value: context
                                                              .read<FeedBloc>(),
                                                        )
                                                      ],
                                                      child:
                                                          const AddStoryPage())));
                                    }
                                  },
                                  child: Column(
                                    children: [
                                      Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            ProfilePhoto(
                                              height: height * 0.09,
                                              width: height * 0.09,
                                              wantBorder: false,
                                              storyAdder: false,
                                              imageUrl:
                                                  state.myData.profilePhotoUrl,
                                            ),
                                            state.myData.addedStory
                                                ? state.myStory.viewed
                                                    ? Container()
                                                    : Container(
                                                        height: height * 0.09,
                                                        width: height * 0.09,
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          border: Border.all(
                                                            width: 2,
                                                            color: Colors
                                                                .pink.shade900,
                                                          ),
                                                        ),
                                                      )
                                                : Positioned(
                                                    bottom: 8,
                                                    right: 8,
                                                    child: Container(
                                                      height: width * 0.04,
                                                      width: width * 0.04,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: instablue,
                                                      ),
                                                      child: const Center(
                                                        child: Icon(
                                                          Icons.add,
                                                          color: Colors.white,
                                                          size: 11,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                          ]),
                                      const InstaText(
                                          fontSize: 10,
                                          color: Colors.white,
                                          fontWeight: FontWeight.normal,
                                          text: "Your story"),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: height * 0.11,
                                width: width * 0.8,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: state.stories.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.5),
                                      child: GestureDetector(
                                        onTap: () {
                                          context.read<FeedBloc>().add(
                                              StoryViewEvent(
                                                  viewMyStory: false,
                                                  index: index));
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      MultiBlocProvider(
                                                          providers: [
                                                            BlocProvider.value(
                                                                value: context.read<
                                                                    HomepageBloc>()),
                                                            BlocProvider(
                                                              create: (context) =>
                                                                  StoryBloc(),
                                                            ),
                                                            BlocProvider.value(
                                                              value: context.read<
                                                                  FeedBloc>(),
                                                            ),
                                                            BlocProvider(
                                                                create: (context) =>
                                                                    ProfileBloc(
                                                                        PageController())),
                                                          ],
                                                          child: ViewStoryPage(
                                                            story: state
                                                                .stories[index]
                                                                .story,
                                                            inProfile: false,
                                                            index: index,
                                                            inSearchProfile:
                                                                false,
                                                          ))));
                                        },
                                        child: Column(
                                          children: [
                                            Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  ProfilePhoto(
                                                    height: height * 0.09,
                                                    width: height * 0.09,
                                                    wantBorder: false,
                                                    storyAdder: false,
                                                    imageUrl: state
                                                        .stories[index]
                                                        .story
                                                        .userProfilePhotoUrl,
                                                  ),
                                                  state.stories[index].viewed
                                                      ? Container()
                                                      : Container(
                                                          height: height * 0.09,
                                                          width: height * 0.09,
                                                          decoration: BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              border: Border.all(
                                                                  width: 2,
                                                                  color: Colors
                                                                      .pink
                                                                      .shade900)),
                                                        )
                                                ]),
                                            InstaText(
                                                fontSize: 10,
                                                color: Colors.white,
                                                fontWeight: FontWeight.normal,
                                                text: state.stories[index].story
                                                    .username),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return PostTile(
                          isFeedData: true,
                          width: width,
                          height: height,
                          profileState: null,
                          searchState: null,
                          index: index - 1,
                          feedState: state,
                          onUserNamePressed: () async {
                            var bloc = context.read<FeedBloc>();
                            bloc.add(
                                FetchUserData(state.posts[index - 1].userId));
                            await bloc.pageController.animateToPage(1,
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.ease);
                          },
                          optionPressed: () {
                            showModalBottomSheet(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                backgroundColor: textFieldBackgroundColor,
                                context: context,
                                builder: (_) => BlocProvider.value(
                                      value: context.read<FeedBloc>(),
                                      child: buildBottomSheet(
                                        context,
                                        height,
                                        width,
                                        index - 1,
                                      ),
                                    ));
                          },
                          likePressed: () {
                            context.read<FeedBloc>().add(PostLikeEvent(
                                state.posts[index - 1].id,
                                index - 1,
                                state.posts[index - 1].userId,
                                true));
                          },
                          onDoubleTap: () {
                            context.read<FeedBloc>().add(PostLikeEvent(
                                state.posts[index - 1].id,
                                index - 1,
                                state.posts[index - 1].userId,
                                true));
                          },
                          commentPressed: () async {
                            var sharedPreferences =
                                await SharedPreferences.getInstance();
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => BlocProvider.value(
                                      value: context.read<FeedBloc>(),
                                      child: CommentPage(
                                        sharedPreferences: sharedPreferences,
                                        feedState: state,
                                        profileState: null,
                                        searchState: null,
                                        postIndex: index - 1,
                                        inFeed: true,
                                      ),
                                    )));
                          },
                          bookmarkPressed: () {
                            context
                                .read<FeedBloc>()
                                .add(BookmarkFeed(index - 1, true));
                          },
                          sharePressed: () async {
                            context.read<FeedBloc>().add(ShareFileEvent(
                                imageUrl: state.posts[index - 1].imageUrl,
                                caption: state.posts[index - 1].caption));
                            await Fluttertoast.showToast(
                                msg: "Please wait !!!",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.white,
                                textColor: Colors.black,
                                fontSize: 14.0);
                          },
                        );
                      }
                    });
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 1,
                  ),
                );
              }
            },
          ),
        ),
        BlocProvider.value(
          value: context.read<FeedBloc>(),
          child: UserProfilePage(
            inSearch: false,
            pageController: context.read<FeedBloc>().pageController,
          ),
        ),
        BlocProvider.value(
          value: context.read<FeedBloc>(),
          child: const UserPosts(
            inProfile: false,
            inFeed: true,
          ),
        )
      ],
    );
  }
}
