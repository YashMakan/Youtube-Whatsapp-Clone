import 'package:flutter/material.dart';
import 'package:whatsapp_redesign/constants/colors.dart';
import 'package:whatsapp_redesign/models/size_config.dart';

import 'gradient_text.dart';

class NoDataFound extends StatelessWidget {
  const NoDataFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GradientWidget(
          gradient: LinearGradient(colors: [
            greenGradient.lightShade,
            greenGradient.darkShade,
          ]),
          child: Icon(
            Icons.info_outline,
            size: SizeConfig.screenWidth * 0.3,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          'No Data Found at the moment',
          style: TextStyle(fontSize: 18),
        )
      ],
    );
  }
}
