import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/constants/colors.dart';
import 'package:instagram_clone/pages/homepage/bloc/homepage_bloc.dart';
import 'package:instagram_clone/pages/homepage/homepage_pages/search/bloc/search_bloc.dart';
import 'package:instagram_clone/widgets/insta_button.dart';
import 'package:instagram_clone/widgets/instatext.dart';
import 'package:instagram_clone/widgets/profile_photo.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key, required this.pageController});
  final PageController pageController;

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
  Widget build(BuildContext context) {
    var homePageBloc = context.read<HomepageBloc>();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            onPressed: () async {
              context.read<SearchBloc>().add(UserProfileBackEvent());
              await widget.pageController.animateToPage(
                0,
                duration: const Duration(milliseconds: 200),
                curve: Curves.ease,
              );
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
            text: state.userData.username,
          ),
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: height,
            width: width,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: height * 0.01, left: 12.0, right: 12.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ProfilePhoto(
                            height: height * 0.13,
                            width: height * 0.13,
                            wantBorder: true,
                            storyAdder: false,
                            imageUrl: state.userData.profilePhotoUrl,
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
                                    text:
                                        state.userData.posts.length.toString(),
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
                                      text:
                                          state.userData.followers.toString()),
                                  const InstaText(
                                      fontSize: 13,
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal,
                                      text: "Followers")
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
                                    text: state.userData.following.toString(),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InstaText(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                text: state.userData.name),
                            SizedBox(
                              height: height * 0.003,
                            ),
                            InstaText(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                                text: state.userData.bio),
                            SizedBox(
                              height: height * 0.003,
                            ),
                            InstaText(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                                text: state.userData.tagline),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      InstaButton(
                        borderWidth: 1,
                        width: double.infinity,
                        postButton: false,
                        height: height * 0.05,
                        buttonColor: instablue,
                        onPressed: () async {},
                        text: "Follow",
                        fontSize: 13,
                        textColor: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ],
                  ),
                ),
                state.userData.private &&
                        state.userData.id !=
                            homePageBloc.sharedPreferences.getString("userId")
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
                              border: Border.all(color: Colors.white, width: 2),
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
                            state.userData.stories.isEmpty
                                ? Container()
                                : SizedBox(
                                    height: height * 0.01,
                                  ),
                            state.userData.stories.isEmpty
                                ? Container()
                                : Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12.0, right: 12.0),
                                    child: SizedBox(
                                      height: height * 0.12,
                                      width: width * 0.7,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount:
                                            state.userData.stories.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.5),
                                            child: Column(
                                              children: [
                                                ProfilePhoto(
                                                  height: height * 0.09,
                                                  width: height * 0.1,
                                                  wantBorder: true,
                                                  storyAdder: false,
                                                  imageUrl: "",
                                                ),
                                                InstaText(
                                                    fontSize: 12,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    text: "Party ${index + 1}")
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Divider(
                              color: profilePhotoBorder,
                              thickness: 0.5,
                            ),
                            SizedBox(
                              height: height * 0.05,
                              width: double.infinity,
                              child: TabBar(
                                  indicatorWeight: 1,
                                  indicatorColor: Colors.white,
                                  controller: tabController,
                                  tabs: [
                                    Tab(
                                      icon: SizedBox(
                                          height: height * 0.03,
                                          child: Image.asset(
                                              'assets/images/selected_grid_icon.png')),
                                    ),
                                    Tab(
                                      icon: SizedBox(
                                          height: height * 0.03,
                                          child: Image.asset(
                                              'assets/images/tag_icon.png')),
                                    )
                                  ]),
                            ),
                            Expanded(
                              child: TabBarView(
                                controller: tabController,
                                children: [
                                  GridView.builder(
                                    itemCount: state.userData.posts.length,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3,
                                            crossAxisSpacing: 4.0,
                                            mainAxisSpacing: 4.0),
                                    itemBuilder: ((context, index) {
                                      return CachedNetworkImage(
                                        imageUrl: state
                                            .userData.posts[index].imageUrl,
                                        fit: BoxFit.fill,
                                        placeholder: (context, val) {
                                          return const Center(
                                            child: CircularProgressIndicator(
                                              strokeWidth: 1,
                                              color: Colors.white,
                                            ),
                                          );
                                        },
                                      );
                                    }),
                                  ),
                                  const Center(
                                    child: Icon(Icons.abc),
                                  )
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
    });
  }
}
