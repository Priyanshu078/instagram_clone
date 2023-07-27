import 'package:dio/dio.dart';

class NotificationService {
  var dio = Dio();
  String url = "https://fcm.googleapis.com/fcm/send";
  String serverKey =
      "AAAA2T_W89M:APA91bFMQmluUwVvuCUZwGw3C7QLC4Ih7y0Fp5ffaKlr10ItleDfTosgOObfo1G2zZxGwpPPvYoB1SrIW-hrUvbxWqst9PgeKdg6p7NQ3qPHjig3i_kI2_RgcoixmmzHDWic4fxh9Pcn";

  Future<void> sendNotification(String title, String imageUrl, String body,
      String message, String receiverFcmToken) async {
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
          "message": message,
        },
        "to": receiverFcmToken,
      },
    );
  }
}
