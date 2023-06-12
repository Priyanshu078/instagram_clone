import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/constants/colors.dart';
import 'package:instagram_clone/pages/chat_page.dart';
import 'package:instagram_clone/widgets/post_tile.dart';
import 'bloc/feed_bloc.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.width;
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
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const ChatPage()));
            },
            icon: SizedBox(
              height: AppBar().preferredSize.height * 0.8,
              width: width * 0.07,
              child: Image.asset('assets/images/messanger.png'),
            ),
          ),
        ],
      ),
      body: BlocBuilder<FeedBloc, FeedState>(
        builder: (context, state) {
          if (state is PostsFetched) {
            return ListView.builder(
                itemCount: state.posts.length,
                itemBuilder: (context, index) {
                  return PostTile(
                    width: width,
                    height: height,
                    profileState: null,
                    searchState: null,
                    index: index,
                    feedState: state,
                  );
                });
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
