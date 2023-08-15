import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/constants/colors.dart';
import 'package:instagram_clone/pages/homepage/homepage_pages/notification/bloc/notification_bloc.dart';
import 'package:instagram_clone/widgets/notification_tile.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          elevation: 0,
          backgroundColor: textFieldBackgroundColor,
          title: SizedBox(
            height: AppBar().preferredSize.height * 0.8,
            width: width * 0.3,
            child: Image.asset('assets/images/instagram.png'),
          )),
      body: BlocBuilder<NotificationBloc, NotificationState>(
          builder: (context, state) {
        if (state is NotificationsInitialState) {
          return const Center(
            child: CircularProgressIndicator(
              strokeWidth: 1,
              color: Colors.white,
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
                physics: const ClampingScrollPhysics(),
                itemCount: state.notifications.length,
                itemBuilder: (context, index) {
                  String dateTime = "";
                  int inDays = DateTime.now()
                      .difference(
                          DateTime.parse(state.notifications[index].dateTime))
                      .inDays;
                  int inHours = DateTime.now()
                      .difference(
                          DateTime.parse(state.notifications[index].dateTime))
                      .inHours;
                  int inMinutes = DateTime.now()
                      .difference(
                          DateTime.parse(state.notifications[index].dateTime))
                      .inMinutes;
                  int inSeconds = DateTime.now()
                      .difference(
                          DateTime.parse(state.notifications[index].dateTime))
                      .inSeconds;
                  if (inDays > 0) {
                    dateTime = '${inDays}d ';
                  } else if (inHours > 0) {
                    dateTime = '${inHours}hr ';
                  } else if (inMinutes > 0) {
                    dateTime = '${inMinutes}m ';
                  } else if (inSeconds > 0) {
                    dateTime = '${inSeconds}s ';
                  }
                  if (kDebugMode) {
                    print(DateTime.now()
                        .difference(
                            DateTime.parse(state.notifications[index].dateTime))
                        .inHours);
                    print(DateTime.now()
                        .difference(
                            DateTime.parse(state.notifications[index].dateTime))
                        .inMinutes);
                  }
                  return NotificationTile(
                      imageUrl: state.notifications[index].imageUrl == ""
                          ? null
                          : state.notifications[index].imageUrl,
                      profilePhotoUrl:
                          state.notifications[index].userProfilePhoto,
                      username:
                          state.notifications[index].message.split(" ")[0],
                      dateTime: dateTime,
                      message: state.notifications[index].message.substring(
                          state.notifications[index].message
                              .split(" ")[0]
                              .length),
                      height: height * 0.1,
                      width: width);
                }),
          );
        }
      }),
    );
  }
}
