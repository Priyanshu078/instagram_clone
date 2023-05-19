import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/pages/homepage/bloc/homepage_bloc.dart';
import 'package:instagram_clone/pages/homepage/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/authentication/auth_pages/loginpage.dart';
import 'pages/authentication/bloc/auth_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool dataSaved = false;

  @override
  void initState() {
    super.initState();
    checkSavedDetails();
  }

  Future checkSavedDetails() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    var data = sharedPreferences.getString('userId');
    print(data);
    if (data != null) {
      setState(() {
        dataSaved = true;
      });
    }
    print(dataSaved);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        duration: 3000,
        centered: true,
        splash: Image.asset('assets/images/instagram_logo.jpg'),
        nextScreen: dataSaved
            ? BlocProvider(
                create: (context) => HomepageBloc(),
                child: const HomePage(),
              )
            : BlocProvider(
                create: (context) => AuthBloc(),
                child: const LoginPage(),
              ),
        backgroundColor: Colors.black);
  }
}
