import 'package:flutter/material.dart';
import 'package:flutter_app/constants/colors.dart';

Widget addStoryWidget(
    {@required double size,
    @required IconData iconData,
    @required String text}) {
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
        child: Icon(
          iconData,
          color: Colors.white,
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Text(
        text,
        style: TextStyle(color: grayColor.lightShade),
      )
    ],
  );
}

Widget storyWidget(
    {@required double size,
    @required String imageUrl,
    @required String text,
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
              image: showGreenStrip?null:DecorationImage(
                  image: NetworkImage(imageUrl), fit: BoxFit.cover),
              border: showGreenStrip?Border.all(color: greenColor, width: 2):null),
          child: showGreenStrip?Padding(
            padding: EdgeInsets.all(showGreenStrip?2.2:0),
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage(imageUrl), fit: BoxFit.cover)),
            ),
          ):null,
        ),
        SizedBox(
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
