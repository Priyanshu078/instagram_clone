import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/constants/colors.dart';
import 'package:instagram_clone/data/stories.dart';
import 'package:instagram_clone/pages/homepage/bloc/homepage_bloc.dart';
import 'package:instagram_clone/pages/homepage/homepage_pages/feed/bloc/feed_bloc.dart';
import 'package:instagram_clone/pages/homepage/homepage_pages/feed/story/bloc/story_bloc.dart';
import 'package:instagram_clone/pages/homepage/homepage_pages/profile/bloc/profile_bloc.dart';
import 'package:instagram_clone/pages/homepage/homepage_pages/search/bloc/search_bloc.dart';
import 'package:instagram_clone/widgets/instatext.dart';
import 'package:instagram_clone/widgets/profile_photo.dart';

class ViewStoryPage extends StatelessWidget {
  const ViewStoryPage(
      {super.key,
      required this.story,
      required this.inProfile,
      required this.index,
      required this.inSearchProfile});

  final Story story;
  final bool inProfile;
  final int index;
  final bool inSearchProfile;

  Widget buildBottomSheet(BuildContext context, double height, double width) {
    return SizedBox(
      height: height * 0.15,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 16.0,
          bottom: 16.0,
        ),
        child: Column(
          children: [
            ListTile(
              minLeadingWidth: 0,
              leading: Icon(
                Icons.delete_outline,
                color: instaRed,
              ),
              title: InstaText(
                fontSize: 17,
                color: instaRed,
                fontWeight: FontWeight.normal,
                text: inProfile ? "Delete Highlight" : "Delete Story",
              ),
              onTap: () {
                // update myData addedstory false in feed and firestore
                if (inProfile) {
                  context.read<ProfileBloc>().add(DeleteHighlight(index));
                } else if (inSearchProfile) {
                  context
                      .read<SearchBloc>()
                      .add(DeleteSearchProfileHighlight(index: index));
                } else {
                  context.read<StoryBloc>().add(DeleteStory());
                }

                Navigator.of(context).pop();
              },
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
    var sharedPreferences = context.read<HomepageBloc>().sharedPreferences;
    return BlocConsumer<SearchBloc, SearchState>(
      listener: (context, searchState) {
        if (searchState is DeletedHighLightSearchState) {
          Navigator.of(context).pop();
        }
      },
      builder: (context, searchState) {
        return BlocConsumer<ProfileBloc, ProfileState>(
          listener: (context, profileState) {
            if (profileState is HighlightDeleted) {
              Navigator.of(context).pop();
            }
          },
          builder: (context, profileState) {
            return BlocConsumer<StoryBloc, StoryState>(
                listener: (context, storyState) {
              if (storyState is StoryDeleted) {
                var bloc = context.read<FeedBloc>();
                bloc.add(DeleteMyStory());
                Navigator.of(context).pop();
              }
            }, builder: (context, storyState) {
              return Scaffold(
                backgroundColor: Colors.black,
                body: Stack(alignment: Alignment.center, children: [
                  SafeArea(
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                ProfilePhoto(
                                  height: height * 0.06,
                                  width: height * 0.065,
                                  wantBorder: false,
                                  storyAdder: false,
                                  imageUrl: story.userProfilePhotoUrl,
                                ),
                                SizedBox(
                                  width: width * 0.02,
                                ),
                                InstaText(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  text: story.username,
                                ),
                              ],
                            ),
                          ),
                          story.userId == sharedPreferences.getString("userId")!
                              ? IconButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        backgroundColor: Colors.black,
                                        context: context,
                                        builder: ((_) => BlocProvider.value(
                                              value: context.read<StoryBloc>(),
                                              child: buildBottomSheet(
                                                  context, height, width),
                                            )));
                                  },
                                  icon: const Icon(
                                    Icons.more_vert,
                                    color: Colors.white,
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            width: double.infinity,
                            imageUrl: story.imageUrl,
                            fit: BoxFit.fill,
                            placeholder: (context, val) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 1,
                                  color: Colors.white,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InstaText(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            text: story.caption),
                      ),
                    ]),
                  ),
                  (storyState is DeletingStoryState ||
                          profileState is DeletingHighLight ||
                          searchState is DeletingHighLightSearchState)
                      ? Container(
                          height: height * 0.15,
                          width: width * 0.7,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: textFieldBackgroundColor),
                          child: Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 1,
                              ),
                              SizedBox(
                                width: width * 0.05,
                              ),
                              InstaText(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  text: inProfile
                                      ? "Deleting Highlight"
                                      : "Deleting Story")
                            ],
                          )),
                        )
                      : Container()
                ]),
              );
            });
          },
        );
      },
    );
  }
}
