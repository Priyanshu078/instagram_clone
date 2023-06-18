import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/constants/colors.dart';
import 'package:instagram_clone/data/comment_data.dart';
import 'package:instagram_clone/pages/homepage/homepage_pages/feed/bloc/feed_bloc.dart';
import 'package:instagram_clone/pages/homepage/homepage_pages/profile/bloc/profile_bloc.dart';
import 'package:instagram_clone/pages/homepage/homepage_pages/search/bloc/search_bloc.dart';
import 'package:instagram_clone/widgets/comment_list.dart';
import 'package:instagram_clone/widgets/insta_textfield.dart';
import 'package:instagram_clone/widgets/instatext.dart';

class CommentPage extends StatefulWidget {
  const CommentPage({
    super.key,
    required this.searchState,
    required this.feedState,
    required this.profileState,
    required this.postIndex,
  });

  final SearchState? searchState;
  final FeedState? feedState;
  final ProfileState? profileState;
  final int postIndex;

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const InstaText(
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.w700,
          text: "Comments",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: widget.searchState != null
                  ? BlocBuilder<SearchBloc, SearchState>(
                      builder: (context, state) {
                        List<Comments> comments = [];
                        if (state.usersPosts) {
                          comments.add(
                            Comments(
                              state.userData.posts[widget.postIndex].caption,
                              state.userData.posts[widget.postIndex]
                                  .userProfilePhotoUrl,
                              state.userData.posts[widget.postIndex].username,
                              state.userData.posts[widget.postIndex].userId,
                            ),
                          );
                          comments.addAll(
                              state.userData.posts[widget.postIndex].comments);
                        } else {
                          comments.add(
                            Comments(
                              state.posts[widget.postIndex].caption,
                              state.posts[widget.postIndex].userProfilePhotoUrl,
                              state.posts[widget.postIndex].username,
                              state.posts[widget.postIndex].userId,
                            ),
                          );
                          comments
                              .addAll(state.posts[widget.postIndex].comments);
                        }
                        return CommentList(
                          width: width,
                          comments: comments,
                          tileHeight: height * 0.08,
                          height: height,
                        );
                      },
                    )
                  : widget.profileState != null
                      ? BlocBuilder<ProfileBloc, ProfileState>(
                          builder: (context, state) {
                            List<Comments> comments = [];
                            comments.add(
                              Comments(
                                state.userData.posts[widget.postIndex].caption,
                                state.userData.posts[widget.postIndex]
                                    .userProfilePhotoUrl,
                                state.userData.posts[widget.postIndex].username,
                                state.userData.posts[widget.postIndex].userId,
                              ),
                            );
                            comments.addAll(state
                                .userData.posts[widget.postIndex].comments);
                            return CommentList(
                              width: width,
                              comments: comments,
                              tileHeight: height * 0.08,
                              height: height,
                            );
                          },
                        )
                      : widget.feedState != null
                          ? BlocBuilder<FeedBloc, FeedState>(
                              builder: (context, state) {
                                List<Comments> comments = [];
                                comments.add(
                                  Comments(
                                    state.posts[widget.postIndex].caption,
                                    state.posts[widget.postIndex]
                                        .userProfilePhotoUrl,
                                    state.posts[widget.postIndex].username,
                                    state.posts[widget.postIndex].userId,
                                  ),
                                );
                                comments.addAll(
                                    state.posts[widget.postIndex].comments);
                                return CommentList(
                                  width: width,
                                  comments: comments,
                                  tileHeight: height * 0.08,
                                  height: height,
                                );
                              },
                            )
                          : CommentList(
                              width: width,
                              comments: const [],
                              tileHeight: height * 0.08,
                              height: height,
                            ),
            ),
            Row(
              children: [
                Expanded(
                    child: InstaTextField(
                        controller: controller,
                        hintText: "comment",
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        hintColor: Colors.white.withOpacity(0.5),
                        obscureText: false,
                        icon: const Icon(
                          Icons.comment,
                          color: Colors.white,
                        ),
                        borderRadius: 0,
                        backgroundColor: Colors.black,
                        forPassword: false,
                        suffixIconCallback: () {},
                        editProfileTextfield: false,
                        enabled: true,
                        onChange: (value) {})),
                GestureDetector(
                  onTap: () {
                    if (widget.searchState != null) {
                    } else if (widget.profileState != null) {
                    } else if (widget.feedState != null) {
                      var bloc = context.read<FeedBloc>();
                      List<Comments> comments =
                          bloc.state.posts[widget.postIndex].comments;
                      bloc.add(AddComment(
                          comments, widget.postIndex, controller.text));
                      controller.clear();
                      FocusManager.instance.primaryFocus!.unfocus();
                    }
                  },
                  child: SizedBox(
                    width: width * 0.15,
                    child: Align(
                      alignment: Alignment.center,
                      child: InstaText(
                          fontSize: 16,
                          color: instablue,
                          fontWeight: FontWeight.w700,
                          text: "Post"),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
