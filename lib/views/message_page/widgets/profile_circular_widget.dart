import 'package:flutter/material.dart';
import 'package:whatsapp_redesign/constants/colors.dart';
import 'package:whatsapp_redesign/models/user.dart';
import 'package:whatsapp_redesign/widgets/custom_circular_image.dart';

class ProfileCircularWidget extends StatefulWidget {
  final User user;

  const ProfileCircularWidget({Key? key, required this.user}) : super(key: key);

  @override
  State<ProfileCircularWidget> createState() => _ProfileCircularWidgetState();
}

class _ProfileCircularWidgetState extends State<ProfileCircularWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        CustomCircularImage(size: 50, user: widget.user),
        Positioned(
          bottom: -5,
          right: -5,
          child: Container(
            decoration: BoxDecoration(
                color: !context.isDarkMode() ? Colors.white : Colors.black,
                border: Border.all(
                    width: 3,
                    color: !context.isDarkMode() ? Colors.white : Colors.black),
                shape: BoxShape.circle),
            child: const Padding(
              padding: EdgeInsets.all(2.0),
              child: Icon(Icons.circle, size: 14, color: greenColor),
            ),
          ),
        )
      ],
    );
  }
}
