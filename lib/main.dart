import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:instagram_clone/firebase_options.dart';
import 'package:instagram_clone/pages/splash_screen/splash_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/utility/firebase_messaging_service.dart';
import 'insta_bloc_observer.dart';
import 'pages/splash_screen/splash_cubit/splash_cubit.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin(); // instance of flutterLocalNotificationsPlugin
const AndroidInitializationSettings androidInitializationSettings =
    AndroidInitializationSettings('@mipmap/notification_icon'); // for android
const DarwinInitializationSettings darwinInitializationSettings =
    DarwinInitializationSettings(); // for iOS
InitializationSettings initializationSettings = const InitializationSettings(
  android: androidInitializationSettings,
  iOS: darwinInitializationSettings,
);

String? fcmToken = "";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  await FirebaseMessagingService().initNotifications();
  Bloc.observer = InstaBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Instagram',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(width: 1, color: Colors.white.withOpacity(0.2)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(width: 1, color: Colors.white.withOpacity(0.2)),
          ),
        ),
      ),
      home: BlocProvider(
        create: (BuildContext context) => SplashCubit(),
        child: const SplashScreen(),
      ),
    );
  }
}
