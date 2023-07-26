import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/constants/colors.dart';
import 'package:instagram_clone/pages/homepage/homepage_pages/notification/bloc/notification_bloc.dart';
import 'package:instagram_clone/widgets/instatext.dart';

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
          return ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return const InstaText(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                    text: "Notifications");
              });
        }
      }),
    );
  }
}
