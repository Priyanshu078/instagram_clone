import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/pages/homepage/bloc/homepage_bloc.dart';
import 'package:instagram_clone/pages/homepage/homepage_pages/feed/feed.dart';
import 'package:instagram_clone/pages/homepage/homepage_pages/notification/notifitcation.dart';
import 'package:instagram_clone/pages/homepage/homepage_pages/posts/post.dart';
import 'package:instagram_clone/pages/homepage/homepage_pages/profile/bloc/profile_bloc.dart';
import 'package:instagram_clone/pages/homepage/homepage_pages/search/search_page.dart';
import 'package:instagram_clone/widgets/profile_widget.dart';
import '../../constants/colors.dart';
import 'homepage_pages/profile/profile.dart';
import 'homepage_pages/search/bloc/search_bloc.dart';

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
    return WillPopScope(
      onWillPop: () async {
        var searchBlocState = context.read<SearchBloc>().state;
        var homePageBlocState = context.read<HomepageBloc>().state;
        if (homePageBlocState.index == 0) {
          return true;
        } else if (homePageBlocState.index == 1) {
          if (searchBlocState is UserProfileState) {
            var bloc = context.read<SearchBloc>();
            await bloc.pageController.animateToPage(0,
                duration: const Duration(milliseconds: 200),
                curve: Curves.ease);
            bloc.add(UserProfileBackEvent());
          } else if (searchBlocState is UsersSearched) {
            context.read<SearchBloc>().searchController.clear();
            context.read<SearchBloc>().focusNode.unfocus();
            context.read<SearchBloc>().add(GetPosts());
          } else if (searchBlocState is PostsFetched) {
            context.read<HomepageBloc>().add(TabChange(0));
          }
          return false;
        } else if (homePageBlocState.index == 2) {
          context.read<HomepageBloc>().add(TabChange(0));
          return false;
        } else if (homePageBlocState.index == 3) {
          context.read<HomepageBloc>().add(TabChange(0));
          return false;
        } else if (homePageBlocState.index == 4) {
          context.read<HomepageBloc>().add(TabChange(0));
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: BlocBuilder<HomepageBloc, HomepageState>(
          builder: (context, state) {
            if (state is HomePageLoadingState) {
              return const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 1,
                  color: Colors.white,
                ),
              );
            } else {
              return pages[state.index];
            }
          },
        ),
        bottomNavigationBar:
            BlocBuilder<HomepageBloc, HomepageState>(builder: (context, state) {
          if (state is HomePageLoadingState) {
            return Container();
          } else {
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
                            ? Image.asset(
                                'assets/images/search_insta_filled.png')
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
                            ? Image.asset(
                                'assets/images/notification_filled.png')
                            : Image.asset('assets/images/notification.png')),
                    label: "Notification"),
                BottomNavigationBarItem(
                    icon: ProfileWidget(
                      url: state.homePageData.url,
                      height: height * 0.035,
                      width: height * 0.035,
                      wantBorder: state.index == 4 ? true : false,
                      photoSelected: true,
                      editProfileImage: false,
                      loading: false,
                    ),
                    label: "Profile"),
              ],
              onTap: (index) async {
                context.read<HomepageBloc>().add(TabChange(index));
                if (index == 1) {
                  var bloc = context.read<SearchBloc>();
                  bloc.add(GetPosts());
                  bloc.searchController.clear();
                  if (bloc.pageController.page == 1) {
                    await bloc.pageController.animateToPage(
                      0,
                      duration: const Duration(microseconds: 200),
                      curve: Curves.ease,
                    );
                  }
                } else if (index == 4) {
                  context.read<ProfileBloc>().add(GetUserDetails());
                }
              },
            );
          }
        }),
      ),
    );
  }
}
