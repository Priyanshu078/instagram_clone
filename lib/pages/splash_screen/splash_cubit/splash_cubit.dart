import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/pages/splash_screen/splash_cubit/splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(const SplashInitial(false, ""));

  // Future<void> checkSavedDetails() async {
  //   var sharedPreferences = await SharedPreferences.getInstance();
  //   var userId = sharedPreferences.getString('userId');
  //   if (userId != null) {
  //     emit(SplashInitial(true, userId));
  //     await FirebaseFirestore.instance
  //         .collection("users")
  //         .doc(userId)
  //         .update({"fcmToken": fcmToken});
  //   }
  // }
}
