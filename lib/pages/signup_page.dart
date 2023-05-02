import 'package:flutter/material.dart';
import 'package:instagram_clone/constants/colors.dart';
import 'package:instagram_clone/pages/loginpage.dart';
import 'package:instagram_clone/widgets/insta_button.dart';
import 'package:instagram_clone/widgets/insta_textfield.dart';
import 'package:instagram_clone/widgets/instatext.dart';

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
            InstaTextField(
              backgroundColor: textFieldBackgroundColor,
              borderRadius: 5,
              icon: null,
              controller: passwordController,
              hintText: "Password",
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.normal,
              hintColor: Colors.white.withOpacity(0.6),
              obscureText: false,
            ),
            SizedBox(
              height: height * 0.05,
            ),
            InstaButton(
                onPressed: () {},
                text: "Sign up",
                fontSize: 14,
                color: Colors.white,
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
