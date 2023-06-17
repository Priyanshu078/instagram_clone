import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/constants/colors.dart';
import 'package:instagram_clone/pages/chat_page.dart';
import 'package:instagram_clone/widgets/instatext.dart';
import 'package:instagram_clone/widgets/post_tile.dart';
import 'bloc/feed_bloc.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  Widget buildBottomSheet(BuildContext context, double height, double width) {
    return SizedBox(
      height: height * 0.3,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 16.0,
          bottom: 16.0,
        ),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {},
              child: Column(
                children: [
                  Container(
                    height: height * 0.09,
                    width: height * 0.09,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/images/insta_bookmark.png',
                        scale: 3.5,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 4.0,
                  ),
                  const InstaText(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                    text: "Save",
                  )
                ],
              ),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Divider(
              color: Colors.white.withOpacity(0.3),
            ),
            ListTile(
              minLeadingWidth: 0,
              leading: const Icon(
                Icons.person_remove,
                color: Colors.white,
              ),
              title: const InstaText(
                fontSize: 17,
                color: Colors.white,
                fontWeight: FontWeight.normal,
                text: "Unfollow",
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
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
                    optionPressed: () {
                      showModalBottomSheet(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          backgroundColor: textFieldBackgroundColor,
                          context: context,
                          builder: (_) => BlocProvider.value(
                                value: context.read<FeedBloc>(),
                                child: buildBottomSheet(
                                  context,
                                  height,
                                  width,
                                ),
                              ));
                    },
                    likePressed: () {
                      context.read<FeedBloc>().add(PostLikeEvent());
                    },
                    onDoubleTap: () {},
                    commentPressed: () {},
                    bookmarkPressed: () {},
                    sharePressed: () {},
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
