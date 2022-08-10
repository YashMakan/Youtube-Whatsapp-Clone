import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lottie/lottie.dart';
import '../constants/colors.dart';
import '../helper/size_config.dart';

enum CustomListTileType { message, group, call, contact }
enum CallStatus { missed, declined, accepted }

class GradientText extends StatelessWidget {
  const GradientText(
    this.text, {
    Key? key,
    required this.gradient,
    this.style,
  }) : super(key: key);

  final String text;
  final TextStyle? style;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
  }
}

Widget gradientIconButton(
    {required double size,
    double? iconSize,
    IconData? iconData,
    Uint8List? imageBytes,
    int? counterText,
    bool isEnabled = true,
    GestureTapCallback? onTap,
    String? text}) {
  return InkWell(
    onTap: onTap,
    child: SizedBox(
      child: Column(
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: isEnabled
                    ? LinearGradient(colors: [
                        greenGradient.lightShade,
                        greenGradient.darkShade,
                      ])
                    : LinearGradient(colors: [
                        Colors.grey,
                        Colors.grey.shade600,
                      ])),
            child: iconData != null
                ? Center(
                    child: Icon(
                      iconData,
                      size: iconSize,
                      color: Colors.white,
                    ),
                  )
                : counterText != null
                    ? Center(
                        child: Text(
                        counterText.toString(),
                        style: const TextStyle(color: Colors.white),
                      ))
                    : imageBytes != null
                        ? Image.memory(
                            imageBytes,
                            width: 24,
                          )
                        : const SizedBox(),
          ),
          text != null
              ? const SizedBox(
                  height: 10,
                )
              : const SizedBox(),
          text != null
              ? Text(
                  text,
                  style:
                      TextStyle(color: grayColor(SizeConfig.cntxt).lightShade),
                )
              : const SizedBox()
        ],
      ),
    ),
  );
}

Widget customListTile(
    {String? imageUrl,
    Uint8List? imageBytes,
    required String title,
    required String subTitle,
    required CustomListTileType customListTileType,
    required GestureTapCallback onTap,
    GestureTapCallback? onLongPress,
    String? timeFrame,
    int? numberOfCalls,
    CallStatus? callStatus,
    List<String>? participantImages,
    int? messageCounter,
    bool isOnline = false,
    bool isSelected = false}) {
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
                                participantImages.length == 1
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
                                              participantImages[1]))),
                                ),
                              ),
                        participantImages == null ||
                                participantImages.length == 1
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
                                                image: MemoryImage(imageBytes))
                                            : DecorationImage(
                                                image: NetworkImage(imageUrl!),
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
                                            participantImages[0]))),
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
                            width:
                                CustomListTileType.contact == customListTileType
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
                                color: grayColor(SizeConfig.cntxt).lightShade),
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
                                color: grayColor(SizeConfig.cntxt).lightShade),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        messageCounter != null
                            ? gradientIconButton(
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

Widget customLoader(context) {
  return Lottie.asset('assets/loader.json',
      width: SizeConfig.screenWidth * 0.3);
}

Widget customBottomSheet() {
  return const SizedBox();
}
