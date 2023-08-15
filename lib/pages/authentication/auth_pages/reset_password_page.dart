import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/constants/colors.dart';
import 'package:instagram_clone/pages/authentication/bloc/auth_bloc.dart';
import 'package:instagram_clone/widgets/insta_snackbar.dart';
import 'package:instagram_clone/widgets/insta_textfield.dart';

import '../../../widgets/insta_button.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is PasswordResetSuccessState) {
          const InstaSnackbar(text: "Password Reset Successfull").show(context);
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * 0.1,
                ),
                SizedBox(
                    height: height * 0.1,
                    width: width * 0.5,
                    child: Image.asset('assets/images/instagram.png')),
                SizedBox(
                  height: height * 0.05,
                ),
                InstaTextField(
                  enabled: true,
                  editProfileTextfield: false,
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
                  onChange: (value) {},
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                InstaTextField(
                  enabled: true,
                  editProfileTextfield: false,
                  forPassword: false,
                  suffixIcon: null,
                  suffixIconCallback: () {},
                  backgroundColor: textFieldBackgroundColor,
                  borderRadius: 5,
                  icon: null,
                  controller: userNameController,
                  hintText: "Username",
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                  hintColor: Colors.white.withOpacity(0.6),
                  obscureText: false,
                  onChange: (value) {},
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return InstaTextField(
                      enabled: true,
                      editProfileTextfield: false,
                      forPassword: true,
                      suffixIcon: state.obscurePassword
                          ? const Icon(
                              Icons.visibility,
                              color: Colors.white,
                            )
                          : const Icon(
                              Icons.visibility_off,
                              color: Colors.white,
                            ),
                      suffixIconCallback: () {
                        context
                            .read<AuthBloc>()
                            .add(ShowPassword(!state.obscurePassword));
                      },
                      backgroundColor: textFieldBackgroundColor,
                      borderRadius: 5,
                      icon: null,
                      controller: passwordController,
                      hintText: "New Password",
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      hintColor: Colors.white.withOpacity(0.6),
                      obscureText: state.obscurePassword,
                      onChange: (value) {},
                    );
                  },
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    if (state is ResettingPasswordState) {
                      return SizedBox(
                        height: height * 0.065,
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 1,
                          ),
                        ),
                      );
                    } else {
                      return InstaButton(
                          borderWidth: 1,
                          width: double.infinity,
                          postButton: false,
                          height: height * 0.065,
                          buttonColor: instablue,
                          onPressed: () {
                            String username = userNameController.text;
                            String password = passwordController.text;
                            String email = emailController.text;
                            context.read<AuthBloc>().add(ResetPasswordEvent(
                                username: username,
                                password: password,
                                email: email));
                          },
                          text: "Reset Password",
                          fontSize: 14,
                          textColor: Colors.white,
                          fontWeight: FontWeight.w700);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
