import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/pages/homepage/homepage_pages/profile/bloc/profile_bloc.dart';
import 'package:instagram_clone/widgets/instatext.dart';

class UserPosts extends StatelessWidget {
  const UserPosts({super.key});

  @override
  Widget build(BuildContext context) {
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
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.w700,
            text: "Posts"),
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          return ListView.builder(
              shrinkWrap: true,
              controller: ScrollController(
                initialScrollOffset: 5,
                keepScrollOffset: true,
              ),
              itemCount: state.userdata.posts.length,
              itemBuilder: (context, index) {
                return CachedNetworkImage(
                  imageUrl: state.userdata.posts[index].imageUrl,
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
              });
        },
      ),
    );
  }
}
