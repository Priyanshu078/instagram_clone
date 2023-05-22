import 'package:flutter/material.dart';
import 'package:instagram_clone/constants/colors.dart';
import 'package:instagram_clone/widgets/insta_textfield.dart';
import 'package:instagram_clone/widgets/instatext.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                obscureText: false),
          ),
        ),
      ),
      body: const Center(
        child: InstaText(
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.w500,
            text: "Search"),
      ),
    );
  }
}
