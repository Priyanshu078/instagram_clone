import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/constants/colors.dart';
import 'package:instagram_clone/data/user_data.dart';
import 'package:instagram_clone/pages/homepage/homepage_pages/profile/bloc/profile_bloc.dart';
import 'package:instagram_clone/widgets/insta_snackbar.dart';
import 'package:instagram_clone/widgets/insta_textfield.dart';
import 'package:instagram_clone/widgets/instatext.dart';
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
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is UserDataEdited) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
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
                onPressed: () {
                  var bloc = context.read<ProfileBloc>();
                  UserData userData = UserData(
                    bloc.state.userdata.id,
                    nameController.text,
                    usernameController.text,
                    bloc.state.userdata.contact,
                    bloc.state.userdata.password,
                    bloc.state.userdata.gender,
                    bioController.text,
                    taglineController.text,
                    bloc.state.userdata.posts,
                    bloc.state.userdata.stories,
                    bloc.state.userdata.followers,
                    bloc.state.userdata.following,
                    bloc.state.userdata.profilePhotoUrl,
                  );
                  const InstaSnackbar(text: "Saving, Please wait !!!")
                      .show(context);
                  bloc.add(EditUserDetails(userData));
                },
                child: InstaText(
                    fontSize: 16,
                    color: instablue,
                    fontWeight: FontWeight.w700,
                    text: "Done"),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: height * 0.01,
              ),
              BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  if (state is ProfilePhotoLoading) {
                    return Align(
                      alignment: Alignment.center,
                      child: ProfileWidget(
                        userData: state.userdata,
                        height: height * 0.15,
                        width: height * 0.15,
                        wantBorder: true,
                        photoSelected:
                            state.userdata.profilePhotoUrl.isNotEmpty,
                        editProfileImage: true,
                        loading: true,
                      ),
                    );
                  } else if (state is ProfilePhotoEdited) {
                    return Align(
                      alignment: Alignment.center,
                      child: ProfileWidget(
                        userData: state.userdata,
                        height: height * 0.15,
                        width: height * 0.15,
                        wantBorder: true,
                        photoSelected:
                            state.userdata.profilePhotoUrl.isNotEmpty,
                        editProfileImage: true,
                        loading: false,
                      ),
                    );
                  } else {
                    return Align(
                      alignment: Alignment.center,
                      child: ProfileWidget(
                        userData: state.userdata,
                        height: height * 0.15,
                        width: height * 0.15,
                        wantBorder: true,
                        photoSelected:
                            state.userdata.profilePhotoUrl.isNotEmpty,
                        editProfileImage: true,
                        loading: false,
                      ),
                    );
                  }
                },
              ),
              TextButton(
                style: TextButton.styleFrom(foregroundColor: Colors.black),
                onPressed: () {
                  var bloc = context.read<ProfileBloc>();
                  bloc.add(ChangeProfilePhotoEvent(bloc.state.userdata));
                },
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
                padding:
                    EdgeInsets.only(left: width * 0.05, right: width * 0.05),
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
                              enabled: true,
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
                              enabled: true,
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
                              enabled: true,
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
                              enabled: true,
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
                              enabled: false,
                              controller: contactController,
                              hintText: "contact",
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
                              enabled: false,
                              controller: genderController,
                              hintText: "gender",
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
        ),
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
