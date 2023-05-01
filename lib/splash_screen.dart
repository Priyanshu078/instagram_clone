import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'pages/loginpage.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        duration: 3000,
        centered: true,
        splash: Image.asset('assets/images/instagram_logo.jpg'),
        nextScreen: const LoginPage(),
        backgroundColor: Colors.black);
  }
}
