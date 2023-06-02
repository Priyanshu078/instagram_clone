import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/constants/colors.dart';
import 'package:instagram_clone/data/posts_data.dart';
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
                    width: double.infinity,
                    postButton: true,
                    onPressed: () {
                      context.read<PostsBloc>().add(ChooseImage());
                    },
                    text: "Choose Image",
                    fontSize: 14,
                    textColor: Colors.white,
                    fontWeight: FontWeight.w700,
                    buttonColor: Colors.black,
                    height: height * 0.08,
                  )
                ],
              );
            } else if (state is PostReady || state is PostingImageState) {
              return Column(
                children: [
                  Expanded(
                    child: Image.file(
                      state.,
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
                  ),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InstaButton(
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
                          width: width * 0.4,
                          onPressed: () {
                            if(state is PostReady){
                            context.read<PostsBloc>().add(PostImage(state.image));
                            }
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
    );
  }
}
