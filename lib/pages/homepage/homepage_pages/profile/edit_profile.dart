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
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController taglineController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController genderController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text =
        BlocProvider.of<ProfileBloc>(context).state.userdata.name;
    usernameController.text =
        BlocProvider.of<ProfileBloc>(context).state.userdata.username;
    bioController.text =
        BlocProvider.of<ProfileBloc>(context).state.userdata.bio;
    taglineController.text =
        BlocProvider.of<ProfileBloc>(context).state.userdata.tagline;
    contactController.text =
        BlocProvider.of<ProfileBloc>(context).state.userdata.contact;
    genderController.text =
        BlocProvider.of<ProfileBloc>(context).state.userdata.gender == 1
            ? "Male"
            : "Female";
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
                      width: width * 0.65,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const InstaText(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        text: "Username"),
                    SizedBox(
                      width: width * 0.65,
                      child: InstaTextField(
                          controller: usernameController,
                          hintText: "username",
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const InstaText(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        text: "Bio"),
                    SizedBox(
                      width: width * 0.65,
                      child: InstaTextField(
                          controller: bioController,
                          hintText: "bio",
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const InstaText(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        text: "Tagline"),
                    SizedBox(
                      width: width * 0.65,
                      child: InstaTextField(
                          controller: taglineController,
                          hintText: "tagline",
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
                SizedBox(
                  height: height * 0.03,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: InstaText(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      text: "Private Information"),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const InstaText(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        text: "Contact"),
                    SizedBox(
                      width: width * 0.65,
                      child: InstaTextField(
                          controller: contactController,
                          hintText: "tagline",
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const InstaText(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        text: "Gender"),
                    SizedBox(
                      width: width * 0.65,
                      child: InstaTextField(
                          controller: genderController,
                          hintText: "tagline",
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
    bioController.dispose();
    taglineController.dispose();
    usernameController.dispose();
    super.dispose();
  }
}
