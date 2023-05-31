import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/constants/colors.dart';
import 'package:instagram_clone/pages/homepage/homepage_pages/profile/bloc/profile_bloc.dart';
import 'package:instagram_clone/pages/homepage/homepage_pages/profile/edit_profile.dart';
import 'package:instagram_clone/widgets/insta_button.dart';
import 'package:instagram_clone/widgets/instatext.dart';
import 'package:instagram_clone/widgets/profile_photo.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is UserDataFetched ||
            state is UserDataEdited ||
            state is ProfilePhotoEdited) {
          return Scaffold(
            backgroundColor: textFieldBackgroundColor,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: textFieldBackgroundColor,
              title: SizedBox(
                height: AppBar().preferredSize.height,
                width: width,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: InstaText(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      text: state.userdata.username),
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: SizedBox(
                    height: AppBar().preferredSize.height * 0.7,
                    width: width * 0.065,
                    child: Image.asset('assets/images/menu_insta.png'),
                  ),
                ),
              ],
            ),
            body: Column(
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
                            imageUrl: state.userdata.profilePhotoUrl,
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
                                      text: state.userdata.posts.length
                                          .toString()),
                                  const InstaText(
                                      fontSize: 13,
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal,
                                      text: "Posts")
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
                                          state.userdata.followers.toString()),
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
                                      text:
                                          state.userdata.following.toString()),
                                  const InstaText(
                                      fontSize: 13,
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal,
                                      text: "Following")
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
                                text: state.userdata.name),
                            SizedBox(
                              height: height * 0.003,
                            ),
                            InstaText(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                                text: state.userdata.bio),
                            SizedBox(
                              height: height * 0.003,
                            ),
                            InstaText(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                                text: state.userdata.tagline),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      InstaButton(
                          width: double.infinity,
                          postButton: false,
                          height: height * 0.05,
                          buttonColor: Colors.black,
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => BlocProvider.value(
                                      value: context.read<ProfileBloc>(),
                                      child: const EditProfile(),
                                    )));
                          },
                          text: "Edit Profile",
                          fontSize: 13,
                          textColor: Colors.white,
                          fontWeight: FontWeight.w700),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Row(
                        children: [
                          Column(
                            children: [
                              ProfilePhoto(
                                height: height * 0.09,
                                width: height * 0.1,
                                wantBorder: true,
                                storyAdder: true,
                                imageUrl: "",
                              ),
                              const InstaText(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  text: "New")
                            ],
                          ),
                          SizedBox(
                            height: height * 0.12,
                            width: width * 0.7,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: state.userdata.stories.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(left: 10.5),
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
                                          fontWeight: FontWeight.normal,
                                          text: "Party ${index + 1}")
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Divider(
                      color: profilePhotoBorder,
                      thickness: 0.5,
                    ),
                  ],
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
                              child:
                                  Image.asset('assets/images/grid_icon.png')),
                        ),
                        Tab(
                          icon: SizedBox(
                              height: height * 0.03,
                              child: Image.asset('assets/images/tag_icon.png')),
                        )
                      ]),
                ),
                Expanded(
                  child: TabBarView(controller: tabController, children: const [
                    Center(
                      child: Icon(Icons.abc),
                    ),
                    Center(
                      child: Icon(Icons.abc),
                    )
                  ]),
                ),
              ],
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(
              strokeWidth: 1,
              color: Colors.white,
            ),
          );
        }
      },
    );
  }
}
