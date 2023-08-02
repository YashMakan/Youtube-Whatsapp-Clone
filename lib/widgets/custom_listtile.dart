import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:whatsapp_redesign/constants/colors.dart';
import 'package:whatsapp_redesign/constants/enums.dart';
import 'package:whatsapp_redesign/models/size_config.dart';
import 'package:whatsapp_redesign/widgets/gradient_icon_button.dart';

class CustomListTile extends StatelessWidget {
  final String? imageUrl;
  final Uint8List? imageBytes;
  final String title;
  final String subTitle;
  final CustomListTileType customListTileType;
  final GestureTapCallback onTap;
  final GestureTapCallback? onLongPress;
  final String? timeFrame;
  final int? numberOfCalls;
  final CallStatus? callStatus;
  final List<String>? participantImages;
  final int? messageCounter;
  final bool isOnline;
  final bool isSelected;

  const CustomListTile(
      {Key? key,
      this.imageUrl,
      this.imageBytes,
      required this.title,
      required this.subTitle,
      required this.customListTileType,
      required this.onTap,
      this.onLongPress,
      this.timeFrame,
      this.numberOfCalls,
      this.callStatus,
      this.participantImages,
      this.messageCounter,
      this.isOnline = false,
      this.isSelected = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      child: SizedBox(
        width: SizeConfig.screenWidth,
        child: Padding(
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
                          participantImages == null ||
                                  participantImages?.length == 1
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
                                            image: NetworkImage(
                                                participantImages![1]))),
                                  ),
                                ),
                          participantImages == null ||
                                  participantImages?.length == 1
                              ? Stack(
                                  children: [
                                    Container(
                                      width: 70,
                                      height: 70,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: imageBytes != null
                                              ? DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image:
                                                      MemoryImage(imageBytes!))
                                              : DecorationImage(
                                                  image:
                                                      NetworkImage(imageUrl!),
                                                  fit: BoxFit.cover)),
                                    ),
                                    if (isSelected)
                                      Container(
                                        width: 70,
                                        height: 70,
                                        child: const Center(
                                          child: Icon(
                                            Icons.check,
                                            color: Colors.white,
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          gradient: LinearGradient(colors: [
                                            greenGradient.lightShade
                                                .withOpacity(0.5),
                                            greenGradient.darkShade
                                                .withOpacity(0.5),
                                          ]),
                                        ),
                                      )
                                  ],
                                )
                              : Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color:
                                              backgroundColor(SizeConfig.cntxt),
                                          width: 3),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              participantImages![0]))),
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
                                border: Border.all(
                                    color: backgroundColor(SizeConfig.cntxt),
                                    width: 2),
                                color: greenColor),
                          ),
                        )
                      : const SizedBox()
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: customListTileType == CustomListTileType.call
                          ? 8.0
                          : 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: SizeConfig.screenWidth - 120,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: CustomListTileType.contact ==
                                      customListTileType
                                  ? SizeConfig.screenWidth - 120
                                  : null,
                              child: Text(
                                title,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color:
                                        blackColor(SizeConfig.cntxt).darkShade),
                              ),
                            ),
                            customListTileType != CustomListTileType.call
                                ? Text(timeFrame!,
                                    style: TextStyle(
                                        color: grayColor(SizeConfig.cntxt)
                                            .lightShade))
                                : const Icon(
                                    LineIcons.video,
                                    color: greenColor,
                                  ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: customListTileType == CustomListTileType.call
                            ? 7
                            : 12,
                      ),
                      Row(
                        children: [
                          if (customListTileType == CustomListTileType.call)
                            callStatus == CallStatus.accepted
                                ? const Icon(
                                    LineIcons.phone,
                                    color: Colors.greenAccent,
                                    size: 15,
                                  )
                                : callStatus == CallStatus.declined
                                    ? const Icon(
                                        LineIcons.alternatePhone,
                                        color: Colors.red,
                                        size: 15,
                                      )
                                    : callStatus == CallStatus.missed
                                        ? const Icon(
                                            LineIcons.phoneSlash,
                                            color: Colors.red,
                                            size: 15,
                                          )
                                        : const SizedBox(),
                          if (customListTileType == CustomListTileType.call)
                            const SizedBox(
                              width: 5,
                            ),
                          if (numberOfCalls != null)
                            Text(
                              "($numberOfCalls)",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(
                                  color:
                                      grayColor(SizeConfig.cntxt).lightShade),
                            ),
                          if (numberOfCalls != null)
                            const SizedBox(
                              width: 5,
                            ),
                          SizedBox(
                            width: customListTileType == CustomListTileType.call
                                ? SizeConfig.screenWidth - 200
                                : SizeConfig.screenWidth - 160,
                            child: Text(
                              subTitle,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(
                                  color:
                                      grayColor(SizeConfig.cntxt).lightShade),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          messageCounter != null
                              ? GradientIconButton(
                                  size: 23, counterText: messageCounter)
                              : const SizedBox()
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
