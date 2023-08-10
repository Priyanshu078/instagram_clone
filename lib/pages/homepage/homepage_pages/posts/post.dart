import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/constants/colors.dart';
import 'package:instagram_clone/pages/homepage/bloc/homepage_bloc.dart';
import 'package:instagram_clone/widgets/insta_button.dart';
import 'package:instagram_clone/widgets/insta_textfield.dart';
import '../../../../widgets/instatext.dart';
import 'bloc/posts_bloc.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final TextEditingController captionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          elevation: 0,
          backgroundColor: textFieldBackgroundColor,
          title: SizedBox(
            height: AppBar().preferredSize.height * 0.8,
            width: width * 0.3,
            child: Image.asset('assets/images/instagram.png'),
          )),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<PostsBloc, PostsState>(
          builder: (context, state) {
            if (state is PostsInitial) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const InstaText(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    text: "Post on Instagram",
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
                          .read<PostsBloc>()
                          .add(const ChooseImage(fromCamera: true));
                    },
                    text: "From Camera",
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
                          .read<PostsBloc>()
                          .add(const ChooseImage(fromCamera: false));
                    },
                    text: "From Gallery",
                    fontSize: 14,
                    textColor: Colors.white,
                    fontWeight: FontWeight.w700,
                    buttonColor: Colors.black,
                    height: height * 0.08,
                    buttonIcon: const Icon(CupertinoIcons.photo_fill),
                  )
                ],
              );
            } else if (state is PostReady) {
              return Column(
                children: [
                  Expanded(
                    child: Image.file(
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
                    hintText: "Post Caption",
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InstaButton(
                          borderWidth: 1,
                          width: width * 0.4,
                          onPressed: () {
                            context.read<PostsBloc>().add(CancelEvent());
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
                            String userProfilePhotoUrl = context
                                .read<HomepageBloc>()
                                .sharedPreferences
                                .getString("profilePhotoUrl")!;
                            context
                                .read<PostsBloc>()
                                .add(PostImage(caption, userProfilePhotoUrl));
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
            } else if (state is PostingImageState) {
              return Column(
                children: [
                  Expanded(
                    child: Image.file(
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
                    hintText: "Post Caption",
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
                  const Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 1,
                    ),
                  ),
                ],
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
