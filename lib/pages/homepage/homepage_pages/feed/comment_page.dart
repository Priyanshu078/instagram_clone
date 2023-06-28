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
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class CommentPage extends StatefulWidget {
  const CommentPage({
    super.key,
    required this.searchState,
    required this.feedState,
    required this.profileState,
    required this.postIndex,
    required this.sharedPreferences,
    required this.inFeed,
  });

  final SearchState? searchState;
  final FeedState? feedState;
  final ProfileState? profileState;
  final int postIndex;
  final SharedPreferences sharedPreferences;
  final bool inFeed;

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
                              state.userData.posts[widget.postIndex].id,
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
                              state.posts[widget.postIndex].id,
                            ),
                          );
                          comments
                              .addAll(state.posts[widget.postIndex].comments);
                        }
                        return CommentList(
                          postIndex: widget.postIndex,
                          width: width,
                          comments: comments,
                          tileHeight: height * 0.08,
                          height: height,
                          sharedPreferences: widget.sharedPreferences,
                          searchComments: true,
                          feedComments: false,
                          profileComments: false,
                          inFeed: false,
                        );
                      },
                    )
                  : widget.profileState != null
                      ? BlocBuilder<ProfileBloc, ProfileState>(
                          builder: (context, state) {
                            List<Comments> comments = [];
                            comments.add(
                              Comments(
                                state.savedPosts
                                    ? state.savedPostsList[widget.postIndex]
                                        .caption
                                    : state.userData.posts[widget.postIndex]
                                        .caption,
                                state.savedPosts
                                    ? state.savedPostsList[widget.postIndex]
                                        .userProfilePhotoUrl
                                    : state.userData.posts[widget.postIndex]
                                        .userProfilePhotoUrl,
                                state.savedPosts
                                    ? state.savedPostsList[widget.postIndex]
                                        .username
                                    : state.userData.posts[widget.postIndex]
                                        .username,
                                state.savedPosts
                                    ? state
                                        .savedPostsList[widget.postIndex].userId
                                    : state.userData.posts[widget.postIndex]
                                        .userId,
                                state.savedPosts
                                    ? state.savedPostsList[widget.postIndex].id
                                    : state.userData.posts[widget.postIndex].id,
                              ),
                            );
                            comments.addAll(state.savedPosts
                                ? state
                                    .savedPostsList[widget.postIndex].comments
                                : state
                                    .userData.posts[widget.postIndex].comments);
                            return CommentList(
                              postIndex: widget.postIndex,
                              width: width,
                              comments: comments,
                              tileHeight: height * 0.08,
                              height: height,
                              sharedPreferences: widget.sharedPreferences,
                              profileComments: true,
                              feedComments: false,
                              searchComments: false,
                              inFeed: false,
                            );
                          },
                        )
                      : widget.feedState != null
                          ? BlocBuilder<FeedBloc, FeedState>(
                              builder: (context, state) {
                                List<Comments> comments = [];
                                String id = const Uuid().v4();
                                if (widget.inFeed) {
                                  comments.add(
                                    Comments(
                                      state.posts[widget.postIndex].caption,
                                      state.posts[widget.postIndex]
                                          .userProfilePhotoUrl,
                                      state.posts[widget.postIndex].username,
                                      state.posts[widget.postIndex].userId,
                                      id,
                                    ),
                                  );
                                  comments.addAll(
                                      state.posts[widget.postIndex].comments);
                                } else {
                                  comments.add(
                                    Comments(
                                      state.userData.posts[widget.postIndex]
                                          .caption,
                                      state.userData.posts[widget.postIndex]
                                          .userProfilePhotoUrl,
                                      state.userData.posts[widget.postIndex]
                                          .username,
                                      state.userData.posts[widget.postIndex]
                                          .userId,
                                      id,
                                    ),
                                  );
                                  comments.addAll(state.userData
                                      .posts[widget.postIndex].comments);
                                }
                                return CommentList(
                                  postIndex: widget.postIndex,
                                  sharedPreferences: widget.sharedPreferences,
                                  width: width,
                                  comments: comments,
                                  tileHeight: height * 0.08,
                                  height: height,
                                  feedComments: true,
                                  inFeed: widget.inFeed,
                                  searchComments: false,
                                  profileComments: false,
                                );
                              },
                            )
                          : CommentList(
                              postIndex: widget.postIndex,
                              width: width,
                              comments: const [],
                              tileHeight: height * 0.08,
                              height: height,
                              sharedPreferences: widget.sharedPreferences,
                              feedComments: true,
                              inFeed: true,
                              profileComments: false,
                              searchComments: false,
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
                      var bloc = context.read<SearchBloc>();
                      List<Comments> comments = bloc.state.usersPosts
                          ? bloc.state.userData.posts[widget.postIndex].comments
                          : bloc.state.posts[widget.postIndex].comments;
                      bloc.add(AddSearchComment(
                          comments, widget.postIndex, controller.text));
                    } else if (widget.profileState != null) {
                      var bloc = context.read<ProfileBloc>();
                      List<Comments> comments = bloc.state.savedPosts
                          ? bloc.state.savedPostsList[widget.postIndex].comments
                          : bloc
                              .state.userData.posts[widget.postIndex].comments;
                      bloc.add(AddProfileComment(
                          comments, widget.postIndex, controller.text));
                    } else if (widget.feedState != null) {
                      var bloc = context.read<FeedBloc>();
                      List<Comments> comments = widget.inFeed
                          ? bloc.state.posts[widget.postIndex].comments
                          : bloc
                              .state.userData.posts[widget.postIndex].comments;
                      if (widget.inFeed) {
                        bloc.add(AddFeedComment(comments, widget.postIndex,
                            controller.text, widget.inFeed));
                      } else {
                        bloc.add(AddFeedComment(comments, widget.postIndex,
                            controller.text, widget.inFeed));
                      }
                    }
                    controller.clear();
                    FocusManager.instance.primaryFocus!.unfocus();
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

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
