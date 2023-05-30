import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:line_icons/line_icons.dart';
import 'package:whatsapp_application/constants/colors.dart';
import 'package:whatsapp_application/models/size_config.dart';

enum SettingTrailing {
  toggle,
  arrow,
}

class SettingTile extends StatelessWidget {
  final IconData iconData;
  final SettingTrailing? settingTrailing;
  final GestureTapCallback? onTap;
  final bool shouldRedGlow;
  final bool shouldGreenGlow;
  final String title;
  final bool? toggle;
  final ValueSetter<bool>? onToggle;

  const SettingTile({
    Key? key,
    required this.iconData,
    this.settingTrailing,
    this.onTap,
    this.shouldRedGlow = false,
    this.shouldGreenGlow = false,
    required this.title,
    this.toggle,
    this.onToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    Icon(
                      iconData,
                      color: shouldRedGlow
                          ? Colors.redAccent
                          : shouldGreenGlow
                              ? greenColor
                              : blackColor(SizeConfig.cntxt).lightShade,
                      size: 26,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      title,
                      style: TextStyle(
                        color: shouldRedGlow
                            ? Colors.redAccent
                            : blackColor(SizeConfig.cntxt).darkShade,
                        fontSize: 17,
                      ),
                    ),
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
                Icon(
                  LineIcons.angleRight,
                  color: blackColor(SizeConfig.cntxt).lightShade,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
