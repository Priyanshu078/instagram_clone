import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/data/user_data.dart';
import 'package:instagram_clone/pages/homepage/bloc/homepage_bloc.dart';
import 'package:instagram_clone/pages/homepage/homepage_pages/feed/feed.dart';
import 'package:instagram_clone/pages/homepage/homepage_pages/notification/notifitcation.dart';
import 'package:instagram_clone/pages/homepage/homepage_pages/posts/post.dart';
import 'package:instagram_clone/pages/homepage/homepage_pages/profile/bloc/profile_bloc.dart';
import 'package:instagram_clone/pages/homepage/homepage_pages/search/search.dart';
import 'package:instagram_clone/widgets/insta_textfield.dart';
import 'package:instagram_clone/widgets/instatext.dart';
import 'package:instagram_clone/widgets/profile_widget.dart';
import '../../constants/colors.dart';
import '../chat_page.dart';
import 'homepage_pages/profile/profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List pages = [
    const FeedPage(),
    SearchPage(),
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
      // appBar: PreferredSize(
      //   preferredSize: Size(double.infinity, AppBar().preferredSize.height),
      //   child: BlocBuilder<HomepageBloc, HomepageState>(
      //     builder: (context, state) {
      //       return AppBar(
      //         elevation: 0,
      //         backgroundColor: textFieldBackgroundColor,
      //         title: state.index == 0
      //             ? SizedBox(
      //                 height: AppBar().preferredSize.height * 0.8,
      //                 width: width * 0.3,
      //                 child: Image.asset('assets/images/instagram.png'),
      //               )
      //             : state.index == 1
      //                 ? SizedBox(
      //                     height: AppBar().preferredSize.height,
      //                     width: double.infinity,
      //                     child: Padding(
      //                       padding:
      //                           const EdgeInsets.only(top: 8.0, bottom: 8.0),
      //                       child: InstaTextField(
      //                           forPassword: false,
      //                           suffixIcon: null,
      //                           suffixIconCallback: () {},
      //                           backgroundColor: searchTextFieldColor,
      //                           borderRadius: 15,
      //                           icon: Icon(
      //                             Icons.search,
      //                             color: searchHintText,
      //                           ),
      //                           controller: searchController,
      //                           hintText: "Search",
      //                           fontSize: 16,
      //                           color: Colors.white,
      //                           fontWeight: FontWeight.normal,
      //                           hintColor: searchHintText,
      //                           obscureText: false),
      //                     ),
      //                   )
      //                 : state.index == 4
      //                     ? SizedBox(
      //                         height: AppBar().preferredSize.height,
      //                         width: width,
      //                         child: const Align(
      //                           alignment: Alignment.centerLeft,
      //                           child: InstaText(
      //                               fontSize: 20,
      //                               color: Colors.white,
      //                               fontWeight: FontWeight.w700,
      //                               text: "priyanshu paliwal"),
      //                         ),
      //                       )
      //                     : SizedBox(
      //                         height: AppBar().preferredSize.height * 0.8,
      //                         width: width * 0.3,
      //                         child: Image.asset('assets/images/instagram.png'),
      //                       ),
      //         actions: state.index == 0
      //             ? [
      //                 IconButton(
      //                   onPressed: () {
      //                     Navigator.of(context).push(MaterialPageRoute(
      //                         builder: (context) => const ChatPage()));
      //                   },
      //                   icon: SizedBox(
      //                     height: AppBar().preferredSize.height * 0.8,
      //                     width: width * 0.07,
      //                     child: Image.asset('assets/images/messanger.png'),
      //                   ),
      //                 ),
      //               ]
      //             : state.index == 4
      //                 ? [
      //                     IconButton(
      //                       onPressed: () {},
      //                       icon: SizedBox(
      //                         height: AppBar().preferredSize.height * 0.7,
      //                         width: width * 0.065,
      //                         child:
      //                             Image.asset('assets/images/menu_insta.png'),
      //                       ),
      //                     ),
      //                   ]
      //                 : [],
      //       );
      //     },
      //   ),
      // ),
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
                        userData: UserData.temp(),
                        height: height * 0.035,
                        width: width * 0.065,
                        wantBorder: true,
                        photoSelected: true,
                        editProfileImage: false,
                      )
                    : ProfileWidget(
                        height: height * 0.035,
                        width: width * 0.065,
                        wantBorder: false,
                        photoSelected: true,
                        editProfileImage: false,
                        userData: UserData.temp(),
                      ),
                label: "Profile"),
          ],
          onTap: (index) {
            context.read<HomepageBloc>().add(TabChange(index));
            if (index == 4) {
              context.read<ProfileBloc>().add(GetUserDetails());
            }
          },
        );
      }),
    );
  }
}
