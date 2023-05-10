import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/constants/colors.dart';
import 'package:instagram_clone/data/user_data.dart';
import 'package:instagram_clone/pages/authentication/bloc/auth_bloc.dart';
import 'package:instagram_clone/pages/authentication/cubit/gender_cubit.dart';
import 'package:instagram_clone/widgets/insta_button.dart';
import 'package:instagram_clone/widgets/insta_textfield.dart';
import 'package:instagram_clone/widgets/instatext.dart';
import 'package:uuid/uuid.dart';

enum Gender { male, female, other }

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  Gender value = Gender.other;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                height: height * 0.1,
                width: width * 0.5,
                child: Image.asset('assets/images/instagram.png'),
              ),
            ),
            SizedBox(
              height: height * 0.04,
            ),
            InstaTextField(
              forPassword: false,
              suffixIcon: null,
              suffixIconCallback: () {},
              backgroundColor: textFieldBackgroundColor,
              borderRadius: 5,
              icon: null,
              controller: emailController,
              hintText: "Phone number or email",
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.normal,
              hintColor: Colors.white.withOpacity(0.6),
              obscureText: false,
            ),
            SizedBox(
              height: height * 0.02,
            ),
            InstaTextField(
              forPassword: false,
              suffixIcon: null,
              suffixIconCallback: () {},
              backgroundColor: textFieldBackgroundColor,
              borderRadius: 5,
              icon: null,
              controller: fullnameController,
              hintText: "Full name",
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.normal,
              hintColor: Colors.white.withOpacity(0.6),
              obscureText: false,
            ),
            SizedBox(
              height: height * 0.02,
            ),
            InstaTextField(
              forPassword: false,
              suffixIcon: null,
              suffixIconCallback: () {},
              backgroundColor: textFieldBackgroundColor,
              borderRadius: 5,
              icon: null,
              controller: usernameController,
              hintText: "Username",
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.normal,
              hintColor: Colors.white.withOpacity(0.6),
              obscureText: false,
            ),
            SizedBox(
              height: height * 0.02,
            ),
            BlocSelector<AuthBloc, AuthState, bool>(
              selector: (state) {
                return state.obscurePassword;
              },
              builder: (context, state) {
                return InstaTextField(
                  backgroundColor: textFieldBackgroundColor,
                  borderRadius: 5,
                  icon: null,
                  controller: passwordController,
                  hintText: "Password",
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                  hintColor: Colors.white.withOpacity(0.6),
                  obscureText: state,
                  forPassword: true,
                  suffixIcon: state
                      ? const Icon(
                          Icons.visibility,
                          color: Colors.white,
                        )
                      : const Icon(
                          Icons.visibility_off,
                          color: Colors.white,
                        ),
                  suffixIconCallback: () {
                    context.read<AuthBloc>().add(ShowPassword(!state));
                  },
                );
              },
            ),
            SizedBox(
              height: height * 0.03,
            ),
            Row(
              children: [
                const InstaText(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                    text: "Gender"),
                SizedBox(
                  width: width * 0.1,
                ),
                Row(
                  children: [
                    BlocBuilder<GenderCubit, GenderState>(
                      builder: (context, state) {
                        return Radio(
                            fillColor: MaterialStateColor.resolveWith(
                                (states) => state.gender == Gender.male
                                    ? Colors.white
                                    : profilePhotoBorder),
                            value: Gender.male,
                            groupValue: state.gender,
                            onChanged: (val) {
                              context
                                  .read<GenderCubit>()
                                  .changeGender(val ?? Gender.male);
                            });
                      },
                    ),
                    const InstaText(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        text: "Male")
                  ],
                ),
                Row(
                  children: [
                    BlocBuilder<GenderCubit, GenderState>(
                      builder: (context, state) {
                        return Radio(
                            fillColor: MaterialStateColor.resolveWith(
                                (states) => state.gender == Gender.female
                                    ? Colors.white
                                    : profilePhotoBorder),
                            value: Gender.female,
                            groupValue: state.gender,
                            onChanged: (val) {
                              context
                                  .read<GenderCubit>()
                                  .changeGender(val ?? Gender.female);
                            });
                      },
                    ),
                    const InstaText(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        text: "Female")
                  ],
                )
              ],
            ),
            SizedBox(
              height: height * 0.03,
            ),
            InstaButton(
                height: height * 0.065,
                buttonColor: instablue,
                onPressed: () async {
                  String uId = const Uuid().v4();
                  UserData userData = UserData(uId, "name", "username",
                      "phoneNumber", "email", "password", Gender.male);
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(uId)
                      .set(userData.toJson());
                },
                text: "Sign up",
                fontSize: 14,
                textColor: Colors.white,
                fontWeight: FontWeight.w700),
            SizedBox(
              height: height * 0.05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InstaText(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.6),
                    fontWeight: FontWeight.normal,
                    text: "Already have an account? "),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: InstaText(
                      fontSize: 14,
                      color: instablue,
                      fontWeight: FontWeight.normal,
                      text: "Log in"),
                )
              ],
            )
          ]),
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    fullnameController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
