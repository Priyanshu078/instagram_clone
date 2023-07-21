import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/constants/colors.dart';
import 'package:instagram_clone/data/user_data.dart';
import 'package:instagram_clone/pages/authentication/bloc/auth_bloc.dart';
import 'package:instagram_clone/widgets/insta_button.dart';
import 'package:instagram_clone/widgets/insta_snackbar.dart';
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
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is SignUpDone) {
          Navigator.of(context).pop();
        } else if (state is ErrorState) {
          const InstaSnackbar(
                  text: "Please try again, something went wrong !!!")
              .show(context);
        } else if (state is FillAllDetails) {
          const InstaSnackbar(text: "Please fill all the details !!!")
              .show(context);
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
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: height * 0.1,
                  width: width * 0.5,
                  child: Image.asset('assets/images/instagram.png'),
                ),
              ),
              SizedBox(
                height: height * 0.03,
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
                controller: fullnameController,
                hintText: "Full name",
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
                controller: usernameController,
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
              BlocSelector<AuthBloc, AuthState, bool>(
                selector: (state) {
                  return state.obscurePassword;
                },
                builder: (context, state) {
                  return InstaTextField(
                    enabled: true,
                    editProfileTextfield: false,
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
                    onChange: (value) {},
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
                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          return Radio(
                              fillColor: MaterialStateColor.resolveWith(
                                  (states) => state.gender == Gender.male
                                      ? Colors.white
                                      : profilePhotoBorder),
                              value: Gender.male,
                              groupValue: state.gender,
                              onChanged: (val) {
                                // print(val);
                                context
                                    .read<AuthBloc>()
                                    .add(ChangeGender(val!));
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
                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          return Radio(
                              fillColor: MaterialStateColor.resolveWith(
                                  (states) => state.gender == Gender.female
                                      ? Colors.white
                                      : profilePhotoBorder),
                              value: Gender.female,
                              groupValue: state.gender,
                              onChanged: (val) {
                                // print(val);
                                context
                                    .read<AuthBloc>()
                                    .add(ChangeGender(val!));
                              });
                        },
                      ),
                      const InstaText(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          text: "Female"),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: height * 0.03,
              ),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is LoadingState) {
                    return SizedBox(
                      height: height * 0.065,
                      child: const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 1,
                          color: Colors.white,
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
                      onPressed: () async {
                        String uId = const Uuid().v4();
                        String name = fullnameController.text;
                        String username = usernameController.text;
                        String contact = emailController.text;
                        String password = passwordController.text;
                        int gender =
                            context.read<AuthBloc>().state.gender == Gender.male
                                ? 1
                                : 0;
                        UserData userData = UserData(
                            uId,
                            name,
                            username,
                            contact,
                            password,
                            gender,
                            "",
                            "",
                            [],
                            [],
                            [],
                            [],
                            "",
                            false,
                            [],
                            false,
                            "");
                        context
                            .read<AuthBloc>()
                            .add(RequestSignUpEvent(userData));
                      },
                      text: "Sign up",
                      fontSize: 14,
                      textColor: Colors.white,
                      fontWeight: FontWeight.w700,
                    );
                  }
                },
              ),
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
