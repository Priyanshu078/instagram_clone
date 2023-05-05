import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'pages/authentication/auth_pages/loginpage.dart';
import 'pages/authentication/bloc/auth_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        duration: 3000,
        centered: true,
        splash: Image.asset('assets/images/instagram_logo.jpg'),
        nextScreen: BlocProvider(
          create: (context) => AuthBloc(),
          child: const LoginPage(),
        ),
        backgroundColor: Colors.black);
  }
}
