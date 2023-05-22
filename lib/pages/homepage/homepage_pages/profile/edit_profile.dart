import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/constants/colors.dart';
import 'package:instagram_clone/pages/homepage/homepage_pages/profile/bloc/profile_bloc.dart';
import 'package:instagram_clone/widgets/insta_textfield.dart';
import 'package:instagram_clone/widgets/instatext.dart';
import 'package:instagram_clone/widgets/profile_photo.dart';
import 'package:instagram_clone/widgets/profile_widget.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text =
        BlocProvider.of<ProfileBloc>(context).state.userdata.name;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leadingWidth: width * 0.2,
        backgroundColor: Colors.black,
        leading: Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            child: TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.black),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const InstaText(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                  text: "Cancel"),
            ),
          ),
        ),
        centerTitle: true,
        title: const InstaText(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.w700,
            text: "Edit Profile"),
        actions: [
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.black),
              onPressed: () {},
              child: InstaText(
                  fontSize: 16,
                  color: instablue,
                  fontWeight: FontWeight.w700,
                  text: "Done"),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: height * 0.01,
          ),
          Align(
            alignment: Alignment.center,
            child: ProfileWidget(
              height: height * 0.15,
              width: height * 0.15,
              wantBorder: true,
              photoSelected: false,
              editProfileImage: true,
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(foregroundColor: Colors.black),
            onPressed: () {},
            child: InstaText(
                fontSize: 13,
                color: instablue,
                fontWeight: FontWeight.w700,
                text: "Change Profile Photo"),
          ),
          SizedBox(
            height: height * 0.01,
          ),
          Padding(
            padding: EdgeInsets.only(left: width * 0.05, right: width * 0.05),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const InstaText(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        text: "Name"),
                    SizedBox(
                      width: width * 0.05,
                    ),
                    Expanded(
                      child: InstaTextField(
                          controller: nameController,
                          hintText: "name",
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          hintColor: Colors.white.withOpacity(0.6),
                          obscureText: false,
                          icon: null,
                          borderRadius: 0,
                          backgroundColor: Colors.black,
                          forPassword: false,
                          suffixIconCallback: () {},
                          editProfileTextfield: true),
                    )
                  ],
                ),
                Row(),
                Row(),
                Row(),
                Row(),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }
}
