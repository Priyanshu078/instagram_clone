import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/pages/homepage/homepage_pages/feed/bloc/feed_bloc.dart';
import 'package:instagram_clone/widgets/insta_textfield.dart';
import 'package:instagram_clone/widgets/instatext.dart';
import '../../../../../constants/colors.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    var feedBloc = context.read<FeedBloc>();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: textFieldBackgroundColor,
        title: InstaText(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.w700,
          text: feedBloc.state.myData.username,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            InstaTextField(
              enabled: true,
              editProfileTextfield: false,
              controller: textEditingController,
              hintText: "Search",
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.normal,
              hintColor: searchHintText,
              obscureText: false,
              icon: Icon(
                Icons.search,
                color: searchHintText,
              ),
              borderRadius: 10,
              backgroundColor: searchTextFieldColor,
              forPassword: false,
              suffixIcon: null,
              suffixIconCallback: () {},
              onChange: (value) {},
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }
}
