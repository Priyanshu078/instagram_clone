import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'pages/loginpage.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return AnimatedSplashScreen(
        duration: 3000,
        centered: true,
        splash: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
                height: height * 0.2,
                width: width * 0.2,
                child: Image.asset('assets/images/instagram_logo.jpg')),
            SizedBox(
              height: height * 0.28,
            ),
            Column(children: [
              const Text(
                "from",
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                height: height * 0.05,
                width: width * 0.4,
                child: Image.asset('assets/images/meta.png'),
              ),
            ]),
            SizedBox(
              height: height * 0.1,
            )
          ],
        ),
        nextScreen: const LoginPage(),
        backgroundColor: Colors.black);
  }
}
