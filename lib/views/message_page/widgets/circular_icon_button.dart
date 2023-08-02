import 'package:flutter/material.dart';
import 'package:whatsapp_redesign/constants/colors.dart';
import 'package:whatsapp_redesign/models/size_config.dart';

class CircularIconButton extends StatelessWidget {
  final IconData iconData;
  final GestureTapCallback? onTap;
  final ValueChanged<LongPressStartDetails>? onLongPressStart;
  final ValueChanged<LongPressEndDetails>? onLongPressEnd;

  const CircularIconButton({
    Key? key,
    required this.iconData,
    this.onTap,
    this.onLongPressStart,
    this.onLongPressEnd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPressStart: onLongPressStart,
      onLongPressEnd: onLongPressEnd,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: blackColor(SizeConfig.cntxt).lightShade.withOpacity(0.5),
          ),
        ),
        child: Center(
          child: Icon(
            iconData,
            size: 25,
            color: blackColor(SizeConfig.cntxt).lightShade.withOpacity(0.5),
          ),
        ),
      ),
    );
  }
}
