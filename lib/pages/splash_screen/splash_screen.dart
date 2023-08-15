import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/main.dart';
import 'package:instagram_clone/pages/homepage/bloc/homepage_bloc.dart';
import 'package:instagram_clone/pages/homepage/homepage.dart';
import 'package:instagram_clone/pages/homepage/homepage_pages/feed/bloc/feed_bloc.dart';
import 'package:instagram_clone/pages/homepage/homepage_pages/posts/bloc/posts_bloc.dart';
import 'package:instagram_clone/pages/homepage/homepage_pages/profile/bloc/profile_bloc.dart';
import 'package:instagram_clone/pages/homepage/homepage_pages/search/bloc/search_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../authentication/auth_pages/loginpage.dart';
import '../authentication/bloc/auth_bloc.dart';
import '../homepage/homepage_pages/notification/bloc/notification_bloc.dart';

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

  Future<void> checkSavedDetails() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    var userId = sharedPreferences.getString('userId');
    if (userId != null) {
      dataSaved = true;
      await FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .update({"fcmToken": fcmToken});
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen.withScreenFunction(
        duration: 3000,
        centered: true,
        splash: Image.asset('assets/images/instagram_logo.jpg'),
        backgroundColor: Colors.black,
        screenFunction: () async {
          if (dataSaved) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => HomepageBloc()..add(GetDetails()),
                ),
                BlocProvider(
                  create: (context) => ProfileBloc(PageController(
                    initialPage: 0,
                  )),
                ),
                BlocProvider(
                  create: (context) => PostsBloc(),
                ),
                BlocProvider(
                  create: (context) => SearchBloc(
                    PageController(
                      initialPage: 1,
                    ),
                    FocusNode(),
                    TextEditingController(),
                  ),
                ),
                BlocProvider(
                  create: (context) => FeedBloc(PageController(initialPage: 0))
                    ..add(const GetFeed(true)),
                ),
                BlocProvider(
                  create: (context) => NotificationBloc(),
                ),
              ],
              child: const HomePage(),
            );
          } else {
            return BlocProvider(
              create: (context) => AuthBloc(),
              child: const LoginPage(),
            );
          }
        });
  }
}
