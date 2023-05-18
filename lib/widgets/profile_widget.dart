import 'package:flutter/material.dart';
import 'package:instagram_clone/constants/colors.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget(
      {super.key,
      required this.height,
      required this.width,
      required this.wantBorder,
      required this.photoSelected});

  final double height;
  final double width;
  final bool wantBorder;
  final bool photoSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: wantBorder
          ? BoxDecoration(
              border: Border.all(
                  color: photoSelected ? Colors.white : searchHintText,
                  width: 1.5),
              shape: BoxShape.circle)
          : null,
      height: height,
      width: width,
      child: photoSelected
          ? const CircleAvatar(
              backgroundImage: AssetImage('assets/images/priyanshuphoto.jpg'),
            )
          : Center(
              child: IconButton(
              icon: Icon(
                Icons.person_add,
                color: searchHintText,
              ),
              onPressed: () {},
            )),
    );
  }
}
