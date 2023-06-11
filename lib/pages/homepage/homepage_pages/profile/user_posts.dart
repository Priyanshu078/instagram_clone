import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/pages/homepage/homepage_pages/profile/bloc/profile_bloc.dart';
import 'package:instagram_clone/widgets/instatext.dart';
import 'package:instagram_clone/widgets/post_tile.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class UserPosts extends StatelessWidget {
  const UserPosts({super.key});

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
            var bloc = context.read<ProfileBloc>();
            await bloc.pageController.animateToPage(0,
                duration: const Duration(
                  milliseconds: 200,
                ),
                curve: Curves.ease);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: const InstaText(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.w700,
            text: "Posts"),
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          return ScrollablePositionedList.builder(
            initialScrollIndex: state.postsIndex,
            itemCount: state.userdata.posts.length,
            itemBuilder: (context, index) {
              return PostTile(
                width: width,
                height: height,
                state: state,
                index: index,
              );
            },
          );
        },
      ),
    );
  }
}
