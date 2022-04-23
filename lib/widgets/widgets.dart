import 'package:flutter/material.dart';
import 'package:flutter_app/constants/colors.dart';

Widget messageListTile({
  @required BuildContext context,
  @required String imageUrl,
  @required String title,
  @required String subTitle,
  @required String timeFrame,
  bool isOnline = false
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
    child: Row(
      children: [
        Stack(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(imageUrl))),
            ),
            isOnline?Positioned(
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
            ):const SizedBox()
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width - 120,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                    Text(timeFrame,
                        style: TextStyle(color: grayColor.lightShade)),
                  ],
                ),
              ),
              SizedBox(
                height: 14,
              ),
              Text(
                subTitle,
                style: TextStyle(color: grayColor.lightShade),
              )
            ],
          ),
        ),
      ],
    ),
  );
}
