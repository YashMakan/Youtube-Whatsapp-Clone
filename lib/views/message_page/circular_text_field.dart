import 'package:flutter/material.dart';
import 'package:whatsapp_application/constants/colors.dart';
import 'package:whatsapp_application/models/size_config.dart';

class CircularTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String> onChanged;
  final ValueChanged<String>? onFieldSubmitted;

  const CircularTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.onChanged,
    this.onFieldSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: !controller.text.contains("\n") ? null : 40,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        border: Border.all(
          color: blackColor(SizeConfig.cntxt).lightShade.withOpacity(0.5),
        ),
      ),
      child: Center(
        child: TextFormField(
          cursorColor: Colors.white,
          style: const TextStyle(color: Colors.white38),
          maxLines: 6,
          minLines: 1,
          controller: controller,
          onChanged: onChanged,
          onFieldSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            contentPadding: const EdgeInsets.only(
              left: 15,
              bottom: 8,
              top: 8,
              right: 15,
            ),
            hintText: hintText,
            hintStyle: TextStyle(
              color: blackColor(SizeConfig.cntxt).darkShade.withOpacity(0.6),
            ),
          ),
        ),
      ),
    );
  }
}
