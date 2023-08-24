import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:whatsapp_redesign/constants/colors.dart';
import 'package:whatsapp_redesign/models/size_config.dart';
import 'package:whatsapp_redesign/models/user.dart';
import 'package:whatsapp_redesign/widgets/custom_circular_image.dart';

class SelectedContactWidget extends StatelessWidget {
  final double size;
  final Contact user;

  const SelectedContactWidget({
    Key? key,
    required this.size,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Container(
            width: size,
            height: size,
            decoration:
                const BoxDecoration(shape: BoxShape.circle, color: greenColor),
            child: const Center(
              child: Icon(
                Icons.person_outline,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: size,
            child: Center(
              child: Text(
                user.displayName,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: grayColor(SizeConfig.cntxt).lightShade,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
