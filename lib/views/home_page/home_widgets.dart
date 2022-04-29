import 'package:flutter/material.dart';

import '../../constants/colors.dart';

Widget gradientIconButton(
    {required double size, IconData? iconData, int? counterText, String? text}) {
  return Column(
    children: [
      Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(colors: [
              greenGradient.lightShade,
              greenGradient.darkShade,
            ])),
        child: iconData!=null?Icon(
          iconData,
          color: Colors.white,
        ):counterText!=null?Center(child: Text(counterText.toString(), style: const TextStyle(color: Colors.white),)):const SizedBox(),
      ),
      text != null
          ? const SizedBox(
              height: 10,
            )
          : const SizedBox(),
      text != null
          ? Text(
              text,
              style: TextStyle(color: grayColor.lightShade),
            )
          : const SizedBox()
    ],
  );
}

Widget storyWidget(
    {required double size,
    required String imageUrl,
    required String text,
    bool showGreenStrip = false}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: Column(
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: showGreenStrip
                  ? null
                  : DecorationImage(
                      image: NetworkImage(imageUrl), fit: BoxFit.cover),
              border: showGreenStrip
                  ? Border.all(color: greenColor, width: 2)
                  : null),
          child: showGreenStrip
              ? Padding(
                  padding: EdgeInsets.all(showGreenStrip ? 2.2 : 0),
                  child: Container(
                    width: size,
                    height: size,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(imageUrl), fit: BoxFit.cover)),
                  ),
                )
              : null,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          text,
          style: TextStyle(color: grayColor.lightShade),
        )
      ],
    ),
  );
}
