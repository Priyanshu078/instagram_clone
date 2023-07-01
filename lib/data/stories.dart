import 'package:instagram_clone/data/posts_data.dart';

class Story {
  final Post post;
  final bool viewed;

  Story({
    required this.post,
    required this.viewed,
  });

  Story copyWith({Post? post, bool? viewed}) {
    return Story(
      post: post ?? this.post,
      viewed: viewed ?? this.viewed,
    );
  }
}
