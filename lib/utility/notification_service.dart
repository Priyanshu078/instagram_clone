import 'package:dio/dio.dart';
import 'api_keys.dart';

class NotificationService {
  var dio = Dio();
  String url = "https://fcm.googleapis.com/fcm/send";
  String serverKey = yourServerKey;

  Future<void> sendNotification(String title, String imageUrl, String body,
      String receiverFcmToken) async {
    await dio.post(
      url,
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "Authorization": "key=$serverKey"
        },
      ),
      data: {
        "notification": {
          "title": title,
          "image": imageUrl,
          "body": body,
        },
        "to": receiverFcmToken,
      },
    );
  }
}
