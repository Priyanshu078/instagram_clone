import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/constants/colors.dart';
import 'package:instagram_clone/widgets/insta_textfield.dart';
import 'package:instagram_clone/widgets/instatext.dart';

import 'bloc/search_bloc.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchController = TextEditingController();

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
          height: AppBar().preferredSize.height,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: InstaTextField(
              enabled: true,
              editProfileTextfield: false,
              forPassword: false,
              suffixIcon: null,
              suffixIconCallback: () {},
              backgroundColor: searchTextFieldColor,
              borderRadius: 15,
              icon: Icon(
                Icons.search,
                color: searchHintText,
              ),
              controller: searchController,
              hintText: "Search",
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.normal,
              hintColor: searchHintText,
              obscureText: false,
              onChange: (value) {
                print(value);
                context.read<SearchBloc>().add(SearchUsers(value));
              },
            ),
          ),
        ),
      ),
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          if (state is SearchInitial) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 1,
              ),
            );
          } else if (state is PostsFetched) {
            return SizedBox(
              width: width,
              height: height,
              child: GridView.builder(
                itemCount: state.posts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                ),
                itemBuilder: (context, index) {
                  return CachedNetworkImage(
                    imageUrl: state.posts[index].imageUrl,
                    fit: BoxFit.fill,
                    placeholder: (context, val) {
                      return const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 1,
                          color: Colors.white,
                        ),
                      );
                    },
                  );
                },
              ),
            );
          } else if (state is UsersSearched) {
            return SizedBox(
              height: height,
              width: width,
              child: ListView.builder(
                  itemCount: state.usersList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: ClipOval(
                        child: Container(
                          decoration:
                              const BoxDecoration(shape: BoxShape.circle),
                          width: width * 0.16,
                          child: CachedNetworkImage(
                            imageUrl: state.usersList[index].profilePhotoUrl,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      title: InstaText(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        text: state.usersList[index].username,
                      ),
                      subtitle: InstaText(
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.5),
                        fontWeight: FontWeight.normal,
                        text: state.usersList[index].name,
                      ),
                    );
                  }),
            );
          } else {
            return const Center(
              child: InstaText(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  text: "Search"),
            );
          }
        },
      ),
    );
  }
}
