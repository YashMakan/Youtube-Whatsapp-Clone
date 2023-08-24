import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:line_icons/line_icons.dart';
import 'package:whatsapp_redesign/constants/colors.dart';
import 'package:whatsapp_redesign/constants/enums.dart';
import 'package:whatsapp_redesign/models/user.dart';
import 'package:whatsapp_redesign/widgets/custom_circular_image.dart';

import '../../models/size_config.dart';

Widget profileWidget(
    {required User user,
    required GestureTapCallback onLogoutClick,
    required GestureTapCallback onTap}) {
  return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          height: 70,
          child: Row(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  CustomCircularImage(size: 70, user: user),
                  Positioned(
                    top: -5,
                    right: -5,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black,
                          border: Border.all(
                              width: 3,
                              color: backgroundColor(SizeConfig.cntxt)),
                          shape: BoxShape.circle),
                      child: const Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Icon(LineIcons.pen, size: 14, color: greenColor),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    style: TextStyle(
                        color: blackColor(SizeConfig.cntxt).darkShade,
                        fontSize: 22,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    "View profile",
                    style: TextStyle(
                        color: blackColor(SizeConfig.cntxt).lightShade),
                  ),
                ],
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 2.0),
                child: GestureDetector(
                    onTap: onLogoutClick,
                    child: const Icon(
                      LineIcons.alternateSignOut,
                      size: 30,
                      color: Colors.redAccent,
                    )),
              )
            ],
          ),
        ),
      ));
}

Widget settingTile(
    {required IconData iconData,
    SettingTrailing? settingTrailing,
    GestureTapCallback? onTap,
    bool shouldRedGlow = false,
    bool shouldGreenGlow = false,
    required String title,
    bool? toggle,
    ValueSetter<bool>? onToggle}) {
  return InkWell(
    onTap: onTap,
    child: SizedBox(
      width: SizeConfig.screenWidth,
      height: 55,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          children: [
            SizedBox(
              child: Row(
                children: [
                  Icon(iconData,
                      color: shouldRedGlow
                          ? Colors.redAccent
                          : shouldGreenGlow
                              ? greenColor
                              : blackColor(SizeConfig.cntxt).lightShade,
                      size: 26),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                        color: shouldRedGlow
                            ? Colors.redAccent
                            : blackColor(SizeConfig.cntxt).darkShade,
                        fontSize: 17),
                  )
                ],
              ),
            ),
            const Spacer(),
            if (settingTrailing == SettingTrailing.toggle)
              FlutterSwitch(
                width: 50,
                padding: 1,
                activeColor: Colors.redAccent,
                height: 25,
                value: toggle!,
                onToggle: onToggle!,
              ),
            if (settingTrailing == SettingTrailing.arrow)
              Icon(LineIcons.angleRight,
                  color: blackColor(SizeConfig.cntxt).lightShade)
          ],
        ),
      ),
    ),
  );
}
