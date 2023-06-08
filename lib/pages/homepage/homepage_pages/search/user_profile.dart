import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/pages/homepage/homepage_pages/search/bloc/search_bloc.dart';
import 'package:instagram_clone/widgets/instatext.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key, required this.pageController});
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () async {
            context.read<SearchBloc>().add(UserProfileBackEvent());
            await pageController.animateToPage(
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
        title: const InstaText(
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.w700,
          text: "gunjan_rusia",
        ),
      ),
    );
  }
}
