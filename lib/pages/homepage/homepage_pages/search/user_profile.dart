import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/constants/colors.dart';
import 'package:instagram_clone/pages/homepage/bloc/homepage_bloc.dart';
import 'package:instagram_clone/pages/homepage/homepage_pages/feed/bloc/feed_bloc.dart';
import 'package:instagram_clone/pages/homepage/homepage_pages/feed/story/bloc/story_bloc.dart';
import 'package:instagram_clone/pages/homepage/homepage_pages/feed/story/view_story.dart';
import 'package:instagram_clone/pages/homepage/homepage_pages/profile/bloc/profile_bloc.dart'
    as p;
import 'package:instagram_clone/pages/homepage/homepage_pages/search/bloc/search_bloc.dart';
import 'package:instagram_clone/widgets/insta_button.dart';
import 'package:instagram_clone/widgets/instatext.dart';
import 'package:instagram_clone/widgets/profile_photo.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage(
      {super.key, required this.pageController, required this.inSearch});
  final PageController pageController;
  final bool inSearch;

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  Widget buildBottomSheet(
      BuildContext context, double height, double width, bool inSearch) {
    return SizedBox(
      height: height * 0.15,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 16.0,
          bottom: 16.0,
        ),
        child: Column(
          children: [
            ListTile(
              minLeadingWidth: 0,
              leading: const Icon(
                Icons.person_remove,
                color: Colors.white,
              ),
              title: const InstaText(
                fontSize: 17,
                color: Colors.white,
                fontWeight: FontWeight.normal,
                text: "Unfollow",
              ),
              onTap: () {
                if (inSearch) {
                  context
                      .read<SearchBloc>()
                      .add(const UnFollowSearchEvent(fromProfile: true));
                } else {
                  context
                      .read<FeedBloc>()
                      .add(const UnFollowFeedEvent(fromFeed: false));
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
    var homePageBloc = context.read<HomepageBloc>();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return BlocBuilder<FeedBloc, FeedState>(
      builder: (context, FeedState feedState) {
        return BlocBuilder<SearchBloc, SearchState>(
            bloc: context.read<SearchBloc>(),
            builder: (context, SearchState searchState) {
              if (!widget.inSearch && feedState is UserDataLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 1,
                  ),
                );
              } else if (widget.inSearch &&
                  (searchState is LoadingUserDataSearchState ||
                      searchState is LoadingUserProfileState)) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 1,
                  ),
                );
              } else {
                return Scaffold(
                  backgroundColor: textFieldBackgroundColor,
                  appBar: AppBar(
                    backgroundColor: textFieldBackgroundColor,
                    leading: IconButton(
                      onPressed: () async {
                        if (widget.inSearch) {
                          if (searchState.previousPage == 1) {
                            context
                                .read<SearchBloc>()
                                .add(UserProfileBackEvent());
                            widget.pageController.jumpToPage(1);
                          } else if (searchState.previousPage == 2) {
                            widget.pageController.jumpToPage(1);
                            context.read<SearchBloc>().add(GetPosts());
                          }
                        } else {
                          var bloc = context.read<FeedBloc>();
                          bloc.add(const GetFeed(false));
                          widget.pageController.jumpToPage(0);
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
                      text: widget.inSearch
                          ? searchState.userData.username
                          : feedState.userData.username,
                    ),
                  ),
                  body: SingleChildScrollView(
                    child: SizedBox(
                      height: height - 2.5 * AppBar().preferredSize.height,
                      width: width,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: height * 0.01, left: 12.0, right: 12.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ProfilePhoto(
                                      height: height * 0.13,
                                      width: height * 0.13,
                                      wantBorder: true,
                                      storyAdder: false,
                                      imageUrl: widget.inSearch
                                          ? searchState.userData.profilePhotoUrl
                                          : feedState.userData.profilePhotoUrl,
                                    ),
                                    SizedBox(
                                      width: width * 0.1,
                                    ),
                                    Row(
                                      children: [
                                        Column(
                                          children: [
                                            InstaText(
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                              text: widget.inSearch
                                                  ? searchState
                                                      .userData.posts.length
                                                      .toString()
                                                  : feedState
                                                      .userData.posts.length
                                                      .toString(),
                                            ),
                                            const InstaText(
                                                fontSize: 13,
                                                color: Colors.white,
                                                fontWeight: FontWeight.normal,
                                                text: "Posts"),
                                          ],
                                        ),
                                        SizedBox(
                                          width: width * 0.05,
                                        ),
                                        Column(
                                          children: [
                                            InstaText(
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                              text: widget.inSearch
                                                  ? searchState
                                                      .userData.followers.length
                                                      .toString()
                                                  : feedState
                                                      .userData.followers.length
                                                      .toString(),
                                            ),
                                            const InstaText(
                                                fontSize: 13,
                                                color: Colors.white,
                                                fontWeight: FontWeight.normal,
                                                text: "Followers"),
                                          ],
                                        ),
                                        SizedBox(
                                          width: width * 0.05,
                                        ),
                                        Column(
                                          children: [
                                            InstaText(
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                              text: widget.inSearch
                                                  ? searchState
                                                      .userData.following.length
                                                      .toString()
                                                  : feedState
                                                      .userData.following.length
                                                      .toString(),
                                            ),
                                            const InstaText(
                                              fontSize: 13,
                                              color: Colors.white,
                                              fontWeight: FontWeight.normal,
                                              text: "Following",
                                            )
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: height * 0.01,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      InstaText(
                                        fontSize: 12,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        text: widget.inSearch
                                            ? searchState.userData.name
                                            : feedState.userData.name,
                                      ),
                                      SizedBox(
                                        height: height * 0.003,
                                      ),
                                      InstaText(
                                          fontSize: 12,
                                          color: Colors.white,
                                          fontWeight: FontWeight.normal,
                                          text: widget.inSearch
                                              ? searchState.userData.bio
                                              : feedState.userData.bio),
                                      SizedBox(
                                        height: height * 0.003,
                                      ),
                                      InstaText(
                                        fontSize: 12,
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal,
                                        text: widget.inSearch
                                            ? searchState.userData.tagline
                                            : feedState.userData.tagline,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.02,
                                ),
                                widget.inSearch
                                    ? (searchState is FollowingSearchState ||
                                            searchState
                                                is UnFollowingSearchState)
                                        ? SizedBox(
                                            height: height * 0.05,
                                            child: const Center(
                                              child: CircularProgressIndicator(
                                                strokeWidth: 1,
                                                color: Colors.white,
                                              ),
                                            ),
                                          )
                                        : searchState.userData.followers
                                                .contains(homePageBloc
                                                    .sharedPreferences
                                                    .getString("userId"))
                                            ? SizedBox(
                                                height: height * 0.05,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    InstaButton(
                                                      borderWidth: 1,
                                                      width: width * 0.43,
                                                      postButton: false,
                                                      height: height * 0.05,
                                                      buttonColor: Colors.black,
                                                      onPressed: () async {
                                                        showModalBottomSheet(
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10)),
                                                            backgroundColor:
                                                                Colors.black,
                                                            context: context,
                                                            builder: (_) =>
                                                                buildBottomSheet(
                                                                  context,
                                                                  height,
                                                                  width,
                                                                  true,
                                                                ));
                                                      },
                                                      text: "following",
                                                      fontSize: 13,
                                                      textColor: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                    InstaButton(
                                                      borderWidth: 1,
                                                      width: width * 0.43,
                                                      postButton: false,
                                                      height: height * 0.05,
                                                      buttonColor: Colors.black,
                                                      onPressed: () async {},
                                                      text: "message",
                                                      fontSize: 13,
                                                      textColor: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    )
                                                  ],
                                                ))
                                            : searchState.userData.id !=
                                                    homePageBloc
                                                        .sharedPreferences
                                                        .getString("userId")
                                                ? InstaButton(
                                                    borderWidth: 1,
                                                    width: double.infinity,
                                                    postButton: false,
                                                    height: height * 0.05,
                                                    buttonColor: instablue,
                                                    onPressed: () async {
                                                      context
                                                          .read<SearchBloc>()
                                                          .add(
                                                              const FollowSearchEvent(
                                                                  fromProfile:
                                                                      true));
                                                    },
                                                    text: "Follow",
                                                    fontSize: 13,
                                                    textColor: Colors.white,
                                                    fontWeight: FontWeight.w700,
                                                  )
                                                : Container()
                                    : (feedState is FollowingFeedState ||
                                            feedState is UnFollowingFeedState)
                                        ? SizedBox(
                                            height: height * 0.05,
                                            child: const Center(
                                              child: CircularProgressIndicator(
                                                strokeWidth: 1,
                                                color: Colors.white,
                                              ),
                                            ),
                                          )
                                        : feedState.userData.followers.contains(
                                                homePageBloc.sharedPreferences
                                                    .getString("userId"))
                                            ? SizedBox(
                                                height: height * 0.05,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    InstaButton(
                                                      borderWidth: 1,
                                                      width: width * 0.43,
                                                      postButton: false,
                                                      height: height * 0.05,
                                                      buttonColor: Colors.black,
                                                      onPressed: () async {
                                                        showModalBottomSheet(
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10)),
                                                            backgroundColor:
                                                                Colors.black,
                                                            context: context,
                                                            builder: (_) =>
                                                                buildBottomSheet(
                                                                  context,
                                                                  height,
                                                                  width,
                                                                  false,
                                                                ));
                                                      },
                                                      text: "following",
                                                      fontSize: 13,
                                                      textColor: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                    InstaButton(
                                                      borderWidth: 1,
                                                      width: width * 0.43,
                                                      postButton: false,
                                                      height: height * 0.05,
                                                      buttonColor: Colors.black,
                                                      onPressed: () async {},
                                                      text: "message",
                                                      fontSize: 13,
                                                      textColor: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    )
                                                  ],
                                                ))
                                            : feedState.userData.id !=
                                                    homePageBloc
                                                        .sharedPreferences
                                                        .getString("userId")
                                                ? InstaButton(
                                                    borderWidth: 1,
                                                    width: double.infinity,
                                                    postButton: false,
                                                    height: height * 0.05,
                                                    buttonColor: instablue,
                                                    onPressed: () async {
                                                      context.read<FeedBloc>().add(
                                                          const FollowFeedEvent(
                                                              fromFeed: false));
                                                    },
                                                    text: "Follow",
                                                    fontSize: 13,
                                                    textColor: Colors.white,
                                                    fontWeight: FontWeight.w700,
                                                  )
                                                : Container(),
                              ],
                            ),
                          ),
                          ((widget.inSearch
                                          ? searchState.userData.private
                                          : feedState.userData.private) &&
                                      (widget.inSearch
                                          ? (searchState.userData.id !=
                                              homePageBloc.sharedPreferences
                                                  .getString("userId"))
                                          : (feedState.userData.id !=
                                              homePageBloc.sharedPreferences
                                                  .getString("userId")))) &&
                                  (widget.inSearch
                                      ? !searchState.userData.followers
                                          .contains(homePageBloc
                                              .sharedPreferences
                                              .getString("userId"))
                                      : !feedState.userData.followers.contains(
                                          homePageBloc.sharedPreferences
                                              .getString("userId")))
                              ? Column(
                                  children: [
                                    SizedBox(
                                      height: height * 0.1,
                                    ),
                                    Container(
                                      height: height * 0.15,
                                      width: height * 0.15,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: Colors.white, width: 2),
                                      ),
                                      child: Center(
                                        child: Image.asset(
                                          "assets/images/lock_icon.png",
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: height * 0.02,
                                    ),
                                    const InstaText(
                                      fontSize: 22,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      text: "This Account",
                                    ),
                                    const InstaText(
                                      fontSize: 22,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      text: "is Private",
                                    ),
                                    SizedBox(
                                      height: height * 0.01,
                                    ),
                                    InstaText(
                                      fontSize: 14,
                                      color: Colors.white.withOpacity(0.7),
                                      fontWeight: FontWeight.normal,
                                      text: "Follow this account to see their",
                                    ),
                                    InstaText(
                                      fontSize: 14,
                                      color: Colors.white.withOpacity(0.7),
                                      fontWeight: FontWeight.normal,
                                      text: "photos and videos",
                                    ),
                                  ],
                                )
                              : Expanded(
                                  child: Column(
                                    children: [
                                      (widget.inSearch
                                              ? searchState
                                                  .userData.stories.isEmpty
                                              : feedState
                                                  .userData.stories.isEmpty)
                                          ? Container()
                                          : SizedBox(
                                              height: height * 0.01,
                                            ),
                                      (widget.inSearch
                                              ? searchState
                                                  .userData.stories.isEmpty
                                              : feedState
                                                  .userData.stories.isEmpty)
                                          ? Container()
                                          : Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0, right: 8.0),
                                              child: SizedBox(
                                                height: height * 0.12,
                                                width: width,
                                                child: ListView.builder(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount: widget.inSearch
                                                      ? searchState.userData
                                                          .stories.length
                                                      : feedState.userData
                                                          .stories.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10.5),
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (_) =>
                                                                      MultiBlocProvider(
                                                                          providers: [
                                                                            BlocProvider.value(
                                                                              value: context.read<SearchBloc>(),
                                                                            ),
                                                                            BlocProvider.value(value: context.read<HomepageBloc>()),
                                                                            BlocProvider(create: (context) => p.ProfileBloc(PageController())),
                                                                            BlocProvider(create: (context) => StoryBloc())
                                                                          ],
                                                                          child:
                                                                              ViewStoryPage(
                                                                            story: widget.inSearch
                                                                                ? searchState.userData.stories[index]
                                                                                : feedState.userData.stories[index],
                                                                            inProfile:
                                                                                false,
                                                                            index:
                                                                                index,
                                                                            inSearchProfile:
                                                                                true,
                                                                          ))));
                                                        },
                                                        child: Column(
                                                          children: [
                                                            ProfilePhoto(
                                                              height:
                                                                  height * 0.1,
                                                              width:
                                                                  height * 0.1,
                                                              wantBorder: true,
                                                              storyAdder: false,
                                                              imageUrl: widget
                                                                      .inSearch
                                                                  ? searchState
                                                                      .userData
                                                                      .stories[
                                                                          index]
                                                                      .imageUrl
                                                                  : feedState
                                                                      .userData
                                                                      .stories[
                                                                          index]
                                                                      .imageUrl,
                                                            ),
                                                            InstaText(
                                                              fontSize: 10,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              text: widget
                                                                      .inSearch
                                                                  ? searchState
                                                                      .userData
                                                                      .stories[
                                                                          index]
                                                                      .caption
                                                                  : feedState
                                                                      .userData
                                                                      .stories[
                                                                          index]
                                                                      .caption,
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                      SizedBox(
                                        height: height * 0.02,
                                      ),
                                      (widget.inSearch
                                              ? searchState
                                                  .userData.stories.isEmpty
                                              : feedState
                                                  .userData.stories.isEmpty)
                                          ? Container()
                                          : Divider(
                                              color: profilePhotoBorder,
                                              thickness: 0.5,
                                            ),
                                      SizedBox(
                                        height: height * 0.05,
                                        width: double.infinity,
                                        child: TabBar(
                                            onTap: (tabIndex) {
                                              if (widget.inSearch) {
                                                context.read<SearchBloc>().add(
                                                    TabChangeEvent(tabIndex));
                                              } else {
                                                context.read<FeedBloc>().add(
                                                    TabChangeFeedEvent(
                                                        tabIndex));
                                              }
                                            },
                                            indicatorWeight: 1,
                                            indicatorColor: Colors.white,
                                            controller: tabController,
                                            tabs: [
                                              Tab(
                                                icon: SizedBox(
                                                  height: height * 0.03,
                                                  child: (widget.inSearch
                                                          ? searchState
                                                                  .tabIndex ==
                                                              0
                                                          : feedState
                                                                  .tabIndex ==
                                                              0)
                                                      ? Image.asset(
                                                          'assets/images/selected_grid_icon.png')
                                                      : Image.asset(
                                                          'assets/images/unselected_grid_icon.png'),
                                                ),
                                              ),
                                              Tab(
                                                icon: SizedBox(
                                                  height: height * 0.03,
                                                  child: (widget.inSearch
                                                          ? searchState
                                                                  .tabIndex ==
                                                              1
                                                          : feedState
                                                                  .tabIndex ==
                                                              1)
                                                      ? Image.asset(
                                                          'assets/images/selected_tag_icon.png')
                                                      : Image.asset(
                                                          'assets/images/tag_icon.png'),
                                                ),
                                              )
                                            ]),
                                      ),
                                      Expanded(
                                        child: TabBarView(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          controller: tabController,
                                          children: [
                                            (widget.inSearch
                                                    ? searchState
                                                        .userData.posts.isEmpty
                                                    : feedState
                                                        .userData.posts.isEmpty)
                                                ? Center(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          height: height * 0.11,
                                                          width: height * 0.11,
                                                          decoration:
                                                              BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            border: Border.all(
                                                                color: Colors
                                                                    .white,
                                                                width: 2),
                                                          ),
                                                          child: Center(
                                                            child: Image.asset(
                                                              "assets/images/insta_camera.png",
                                                              scale: 2.5,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: height * 0.01,
                                                        ),
                                                        const InstaText(
                                                            fontSize: 20,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            text:
                                                                "No Posts Yet")
                                                      ],
                                                    ),
                                                  )
                                                : GridView.builder(
                                                    itemCount: widget.inSearch
                                                        ? searchState.userData
                                                            .posts.length
                                                        : feedState.userData
                                                            .posts.length,
                                                    gridDelegate:
                                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                                            crossAxisCount: 3,
                                                            crossAxisSpacing:
                                                                4.0,
                                                            mainAxisSpacing:
                                                                4.0),
                                                    itemBuilder:
                                                        ((context, index) {
                                                      return InkWell(
                                                        onTap: () async {
                                                          if (widget.inSearch) {
                                                            var bloc =
                                                                context.read<
                                                                    SearchBloc>();
                                                            bloc.add(
                                                                PostsIndexChangeEvent(
                                                                    index,
                                                                    true));
                                                            await bloc
                                                                .pageController
                                                                .animateToPage(
                                                              2,
                                                              duration:
                                                                  const Duration(
                                                                      milliseconds:
                                                                          200),
                                                              curve:
                                                                  Curves.ease,
                                                            );
                                                          } else {
                                                            var bloc =
                                                                context.read<
                                                                    FeedBloc>();
                                                            bloc.add(
                                                                FeedPostsIndexChangeEvent(
                                                              index,
                                                            ));
                                                            await bloc
                                                                .pageController
                                                                .animateToPage(
                                                              2,
                                                              duration:
                                                                  const Duration(
                                                                      milliseconds:
                                                                          200),
                                                              curve:
                                                                  Curves.ease,
                                                            );
                                                          }
                                                        },
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl: widget
                                                                  .inSearch
                                                              ? searchState
                                                                  .userData
                                                                  .posts[index]
                                                                  .imageUrl
                                                              : feedState
                                                                  .userData
                                                                  .posts[index]
                                                                  .imageUrl,
                                                          fit: BoxFit.fill,
                                                          placeholder:
                                                              (context, val) {
                                                            return const Center(
                                                              child:
                                                                  CircularProgressIndicator(
                                                                strokeWidth: 1,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      );
                                                    }),
                                                  ),
                                            Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    height: height * 0.11,
                                                    width: height * 0.11,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                            color: Colors.white,
                                                            width: 2)),
                                                    child: Center(
                                                      child: Image.asset(
                                                        "assets/images/selected_tag_icon.png",
                                                        scale: 2.5,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: height * 0.01,
                                                  ),
                                                  const InstaText(
                                                      fontSize: 20,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      text: "No Posts Yet")
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                );
              }
            });
      },
    );
  }
}
