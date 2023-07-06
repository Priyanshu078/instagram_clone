import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/constants/colors.dart';
import 'package:instagram_clone/pages/homepage/homepage_pages/profile/bloc/profile_bloc.dart';
import 'package:instagram_clone/widgets/instatext.dart';

class PreviousStories extends StatelessWidget {
  const PreviousStories({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is HighLightAddedState) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const InstaText(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.w700,
              text: "New highlight"),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is FetchedPreviousStories) {
              if (state.previousStories.isEmpty) {
                return const Center(
                  child: InstaText(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      text: "No Stories Yet"),
                );
              } else {
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 4.0),
                  itemCount: state.previousStories.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () async {
                        context
                            .read<ProfileBloc>()
                            .add(AddHighlight(state.previousStories[index]));
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: state.previousStories[index].imageUrl,
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
                    );
                  },
                );
              }
            } else if (state is AddingHighLight) {
              return Center(
                child: Container(
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
                      const InstaText(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          text: "Adding Highlight")
                    ],
                  )),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 1,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
