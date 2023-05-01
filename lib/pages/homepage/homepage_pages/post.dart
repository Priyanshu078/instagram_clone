import 'package:flutter/material.dart';

import '../../../widgets/instatext.dart';

class PostPage extends StatelessWidget {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: InstaText(
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.w500,
            text: "Post"),
      ),
    );
    ;
  }
}
