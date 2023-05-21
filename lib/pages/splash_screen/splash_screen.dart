import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/pages/homepage/bloc/homepage_bloc.dart';
import 'package:instagram_clone/pages/homepage/homepage.dart';
import 'package:instagram_clone/pages/homepage/homepage_pages/profile/bloc/profile_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../authentication/auth_pages/loginpage.dart';
import '../authentication/bloc/auth_bloc.dart';
import 'splash_cubit/splash_cubit.dart';
import 'splash_cubit/splash_state.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SplashCubit, SplashState>(builder: (context, state) {
      return AnimatedSplashScreen(
        duration: 3000,
        centered: true,
        splash: Image.asset('assets/images/instagram_logo.jpg'),
        backgroundColor: Colors.black,
        nextScreen: state.dataSaved
            ? MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => HomepageBloc(),
                  ),
                  BlocProvider(
                    create: (context) => ProfileBloc(),
                  ),
                ],
                child: const HomePage(),
              )
            : BlocProvider(
                create: (context) => AuthBloc(),
                child: const LoginPage(),
              ),
      );
    });
  }
}
