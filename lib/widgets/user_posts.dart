import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/pages/homepage/homepage_pages/profile/bloc/profile_bloc.dart';
import 'package:instagram_clone/pages/homepage/homepage_pages/search/bloc/search_bloc.dart';
import 'package:instagram_clone/widgets/instatext.dart';
import 'package:instagram_clone/widgets/post_tile.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../constants/colors.dart';

class UserPosts extends StatelessWidget {
  const UserPosts({
    super.key,
    required this.inProfile,
  });
  final bool inProfile;

  Widget buildBottomSheet(BuildContext context, double height, double width) {
    return SizedBox(
      height: height * 0.3,
      child: Padding(
        padding: EdgeInsets.fromLTRB(width * 0.05, 8.0, width * 0.05, 8.0),
        child: Column(),
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
            if (inProfile) {
              var bloc = context.read<ProfileBloc>();
              bloc.pageController.jumpToPage(0);
            } else {
              var bloc = context.read<SearchBloc>();
              if (bloc.state.usersPosts) {
                bloc.pageController.jumpToPage(1);
              } else {
                bloc.pageController.jumpToPage(0);
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
          text: (inProfile || context.read<SearchBloc>().state.usersPosts)
              ? "Posts"
              : "Explore",
        ),
      ),
      body: inProfile
          ? BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                return ScrollablePositionedList.builder(
                  initialScrollIndex: state.postsIndex,
                  itemCount: state.userData.posts.length,
                  itemBuilder: (context, index) {
                    return PostTile(
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
                                  ),
                                ));
                      },
                    );
                  },
                );
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
                                  ),
                                ));
                      },
                    );
                  },
                );
              },
            ),
    );
  }
}
