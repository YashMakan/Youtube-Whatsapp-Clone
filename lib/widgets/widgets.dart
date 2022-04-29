import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../views/home_page/home_widgets.dart';

enum homeTiles { message, group }

Widget homeListTile(
    {required BuildContext context,
    required String imageUrl,
    required String title,
    required String subTitle,
    required String timeFrame,
    required homeTiles tiles,
    List<String>? participantImages,
    int? messageCounter,
    bool isOnline = false}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
    child: Row(
      children: [
        Stack(
          children: [
            SizedBox(
                width: 70,
                height: 70,
                child: Stack(
                  children: [
                    participantImages == null || participantImages.length == 1
                        ? const SizedBox()
                        : Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 47,
                              height: 47,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image:
                                          NetworkImage(participantImages[1]))),
                            ),
                          ),
                    participantImages == null || participantImages.length == 1
                        ? Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(imageUrl))),
                          )
                        : Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: Colors.white, width: 3),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(participantImages[0]))),
                          ),
                  ],
                )),
            isOnline
                ? Positioned(
                    bottom: 3,
                    right: 3,
                    child: Container(
                      width: 15,
                      height: 15,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                          color: greenColor),
                    ),
                  )
                : const SizedBox()
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - 120,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w700, color: blackColor(context).darkShade),
                    ),
                    Text(timeFrame,
                        style: TextStyle(color: grayColor.lightShade)),
                  ],
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 120,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      subTitle,
                      style: TextStyle(color: grayColor.lightShade),
                    ),
                    messageCounter != null
                        ? gradientIconButton(
                            size: 23, counterText: messageCounter)
                        : const SizedBox()
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    ),
  );
}
