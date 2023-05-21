import 'package:flutter/material.dart';
import 'package:instagram_clone/constants/colors.dart';
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
    return Scaffold(
      backgroundColor: textFieldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: textFieldBackgroundColor,
        title: SizedBox(
          height: AppBar().preferredSize.height,
          width: width,
          child: const Align(
            alignment: Alignment.centerLeft,
            child: InstaText(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.w700,
                text: "priyanshu paliwal"),
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
            padding:
                EdgeInsets.only(top: height * 0.01, left: 12.0, right: 12.0),
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
                    ),
                    SizedBox(
                      width: width * 0.1,
                    ),
                    Row(
                      children: [
                        Column(
                          children: const [
                            InstaText(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                text: "1"),
                            InstaText(
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
                          children: const [
                            InstaText(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                text: "1"),
                            InstaText(
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
                          children: const [
                            InstaText(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                text: "1"),
                            InstaText(
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
                      const InstaText(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          text: "Priyanshu Paliwal"),
                      SizedBox(
                        height: height * 0.003,
                      ),
                      const InstaText(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          text:
                              "Flutter Developer, Public Speaker, Multi Billionare"),
                      SizedBox(
                        height: height * 0.003,
                      ),
                      const InstaText(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          text: "Love Yourself"),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                InstaButton(
                    height: height * 0.05,
                    buttonColor: Colors.black,
                    onPressed: () {},
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
                            storyAdder: true),
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
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 10.5),
                            child: Column(
                              children: [
                                ProfilePhoto(
                                    height: height * 0.09,
                                    width: height * 0.1,
                                    wantBorder: true,
                                    storyAdder: false),
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
                        child: Image.asset('assets/images/grid_icon.png')),
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
  }
}
