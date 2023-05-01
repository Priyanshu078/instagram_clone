import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/pages/homepage/bloc/homepage_bloc.dart';
import 'package:instagram_clone/pages/homepage/homepage_pages/feed.dart';
import 'package:instagram_clone/pages/homepage/homepage_pages/notifitcation.dart';
import 'package:instagram_clone/pages/homepage/homepage_pages/post.dart';
import 'package:instagram_clone/pages/homepage/homepage_pages/search.dart';
import 'package:instagram_clone/widgets/profile_photo.dart';

import '../../constants/colors.dart';
import 'homepage_pages/profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List pages = [
    const FeedPage(),
    const SearchPage(),
    const PostPage(),
    const NotificationPage(),
    const ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: textFieldBackgroundColor,
        title: SizedBox(
          height: AppBar().preferredSize.height * 0.8,
          width: width * 0.3,
          child: Image.asset('assets/images/instagram.png'),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: SizedBox(
              height: AppBar().preferredSize.height * 0.8,
              width: width * 0.07,
              child: Image.asset('assets/images/messanger.png'),
            ),
          ),
        ],
      ),
      body: BlocBuilder<HomepageBloc, HomepageState>(
        builder: (context, state) {
          return pages[state.index];
        },
      ),
      bottomNavigationBar:
          BlocBuilder<HomepageBloc, HomepageState>(builder: (context, state) {
        return BottomNavigationBar(
          elevation: 0,
          currentIndex: state.index,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          backgroundColor: textFieldBackgroundColor,
          items: [
            BottomNavigationBarItem(
                icon: SizedBox(
                  // height: height * 0.05,
                  width: width * 0.065,
                  child: state.index == 0
                      ? Image.asset('assets/images/home_filled.png')
                      : Image.asset('assets/images/home.png'),
                ),
                label: "Home"),
            BottomNavigationBarItem(
                icon: SizedBox(
                    // height: height * 0.05,
                    width: width * 0.065,
                    child: state.index == 1
                        ? Image.asset('assets/images/search_insta_filled.png')
                        : Image.asset('assets/images/search_insta.png')),
                label: "Search"),
            BottomNavigationBarItem(
                icon: SizedBox(
                    // height: height * 0.05,
                    width: width * 0.065,
                    child: Image.asset('assets/images/post.png')),
                label: "Post"),
            BottomNavigationBarItem(
                icon: SizedBox(
                    // height: height * 0.05,
                    width: width * 0.065,
                    child: state.index == 3
                        ? Image.asset('assets/images/notification_filled.png')
                        : Image.asset('assets/images/notification.png')),
                label: "Notification"),
            BottomNavigationBarItem(
                icon: state.index == 4
                    ? ProfileWidget(
                        height: height * 0.035,
                        width: width * 0.065,
                        wantBorder: true)
                    : ProfileWidget(
                        height: height * 0.035,
                        width: width * 0.065,
                        wantBorder: false,
                      ),
                label: "Profile"),
          ],
          onTap: (index) {
            context.read<HomepageBloc>().add(TabChange(index));
          },
        );
      }),
    );
  }
}
