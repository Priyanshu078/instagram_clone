import 'package:dio/dio.dart';
import 'api_keys.dart';

class NotificationService {
  var dio = Dio();
  String url = "https://fcm.googleapis.com/fcm/send";
  String serverKey = yourServerKey;

  Future<void> sendNotification(String title, String imageUrl, String body,
      List receiverFcmToken, bool isMulticast) async {
    await dio.post(
      url,
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "Authorization": "key=$serverKey"
        },
      ),
      data: isMulticast
          ? {
              "notification": {
                "title": title,
                "image": imageUrl,
                "body": body,
              },
              "registration_ids": receiverFcmToken,
            }
          : {
              "notification": {
                "title": title,
                "image": imageUrl,
                "body": body,
              },
              "to": receiverFcmToken[0],
            },
    );
  }
}
