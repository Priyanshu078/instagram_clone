import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/pages/homepage/homepage_pages/profile/bloc/profile_bloc.dart';
import 'package:instagram_clone/widgets/instatext.dart';

class PreviousStories extends StatelessWidget {
  const PreviousStories({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const InstaText(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.w700,
            text: "New highlight"),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is FetchedPreviousStories) {
            return const Center(
              child: InstaText(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  text: "No Stories Yet"),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 1,
              ),
            );
          }
        },
      ),
    );
  }
}
