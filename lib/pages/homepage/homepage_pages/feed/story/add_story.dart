import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/constants/colors.dart';
import 'package:instagram_clone/pages/homepage/homepage_pages/feed/bloc/feed_bloc.dart';
import 'package:instagram_clone/pages/homepage/homepage_pages/feed/story/bloc/story_bloc.dart';
import 'package:instagram_clone/widgets/insta_button.dart';
import 'package:instagram_clone/widgets/insta_textfield.dart';
import 'package:instagram_clone/widgets/instatext.dart';

class AddStoryPage extends StatefulWidget {
  const AddStoryPage({super.key});

  @override
  State<AddStoryPage> createState() => _AddStoryPageState();
}

class _AddStoryPageState extends State<AddStoryPage> {
  final TextEditingController captionController = TextEditingController();

  @override
  void dispose() {
    captionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        var bloc = context.read<StoryBloc>();
        if (bloc.state is StoryInitial) {
          return true;
        } else {
          bloc.add(CancelEvent());
          return false;
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          title: const InstaText(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.w700,
              text: "Add to story"),
          leading: IconButton(
            onPressed: () {
              var bloc = context.read<StoryBloc>();
              if (bloc.state is StoryInitial) {
                Navigator.of(context).pop();
              } else {
                bloc.add(CancelEvent());
              }
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        body: BlocListener<StoryBloc, StoryState>(
          listener: (context, state) {
            if (state is StoryPosted) {
              var feedbloc = context.read<FeedBloc>();
              feedbloc.add(GetMyStory());
              Navigator.of(context).pop();
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocBuilder<StoryBloc, StoryState>(
              builder: (context, state) {
                if (state is StoryInitial) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const InstaText(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        text: "Add Story on Instagram",
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      InstaButton(
                        borderWidth: 1,
                        width: width,
                        postButton: true,
                        onPressed: () {
                          context
                              .read<StoryBloc>()
                              .add(const ChooseImageEvent(false));
                        },
                        text: "From camera",
                        fontSize: 14,
                        textColor: Colors.white,
                        fontWeight: FontWeight.w700,
                        buttonColor: Colors.black,
                        height: height * 0.08,
                        buttonIcon: const Icon(Icons.camera_alt_outlined),
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      InstaButton(
                        borderWidth: 1,
                        width: width,
                        postButton: true,
                        onPressed: () {
                          context
                              .read<StoryBloc>()
                              .add(const ChooseImageEvent(true));
                        },
                        text: "From gallery",
                        fontSize: 14,
                        textColor: Colors.white,
                        fontWeight: FontWeight.w700,
                        buttonColor: Colors.black,
                        height: height * 0.08,
                        buttonIcon: const Icon(CupertinoIcons.photo_fill),
                      )
                    ],
                  );
                } else if (state is StoryReadyState ||
                    state is StoryPostingState) {
                  return Column(
                    children: [
                      Expanded(
                        child: Image.file(
                          fit: BoxFit.cover,
                          width: width,
                          File(state.imagePath),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.04,
                      ),
                      InstaTextField(
                        enabled: true,
                        editProfileTextfield: false,
                        backgroundColor: textFieldBackgroundColor,
                        borderRadius: 5,
                        icon: null,
                        controller: captionController,
                        hintText: "Story Caption",
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        hintColor: Colors.white.withOpacity(0.6),
                        obscureText: false,
                        forPassword: false,
                        suffixIcon: null,
                        suffixIconCallback: () {},
                        onChange: (value) {},
                      ),
                      SizedBox(
                        height: height * 0.04,
                      ),
                      state is StoryPostingState
                          ? const Align(
                              alignment: Alignment.center,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 1,
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InstaButton(
                                    borderWidth: 1,
                                    width: width * 0.4,
                                    onPressed: () {
                                      context
                                          .read<StoryBloc>()
                                          .add(CancelEvent());
                                    },
                                    text: "Cancel",
                                    fontSize: 14,
                                    textColor: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    buttonColor: Colors.black,
                                    height: height * 0.05,
                                    postButton: true),
                                SizedBox(
                                  width: width * 0.01,
                                ),
                                InstaButton(
                                    borderWidth: 1,
                                    width: width * 0.4,
                                    onPressed: () {
                                      String caption = captionController.text;
                                      context
                                          .read<StoryBloc>()
                                          .add(PostStory(caption));
                                    },
                                    text: "Post",
                                    fontSize: 14,
                                    textColor: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    buttonColor: Colors.white,
                                    height: height * 0.05,
                                    postButton: true),
                              ],
                            )
                    ],
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
