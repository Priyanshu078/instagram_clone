import 'package:flutter/material.dart';
import 'package:instagram_clone/data/stories.dart';
import 'package:instagram_clone/widgets/instatext.dart';

class ViewStoryPage extends StatelessWidget {
  const ViewStoryPage({super.key, required this.story});

  final Story story;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image.network(story.imageUrl),
        InstaText(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.w600,
            text: story.caption),
      ]),
    );
  }
}
