import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:whatsapp_application/constants/colors.dart';
import 'package:whatsapp_application/models/size_config.dart';

class GradientIconButton extends StatelessWidget {
  final double size;
  final double? iconSize;
  final IconData? iconData;
  final Uint8List? imageBytes;
  final int? counterText;
  final bool isEnabled;
  final GestureTapCallback? onTap;
  final String? text;

  const GradientIconButton(
      {Key? key,
      required this.size,
      this.iconSize,
      this.iconData,
      this.imageBytes,
      this.counterText,
      this.isEnabled = true,
      this.onTap,
      this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                              imageBytes!,
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
                    text!,
                    style: TextStyle(
                        color: grayColor(SizeConfig.cntxt).lightShade),
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
