import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/pages/splash_screen/splash_cubit/splash_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(const SplashInitial(false));

  Future<void> checkSavedDetails() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    var data = sharedPreferences.getString('userId');
    if (data != null) {
      emit(const SplashInitial(true));
      String? fcmToken = await FirebaseMessaging.instance.getToken();
      await FirebaseFirestore.instance
          .collection("users")
          .doc(data)
          .update({"fcmToken": fcmToken});
      print("fcm Token $fcmToken");
    }
  }
}
