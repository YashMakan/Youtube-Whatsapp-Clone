import 'package:flutter/material.dart';
import 'package:whatsapp_application/constants/colors.dart';
import 'package:whatsapp_application/models/size_config.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  const SearchBar({
    Key? key,
    required this.controller,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const ValueKey<int>(0),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: SizeConfig.screenWidth,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              color: Color.fromRGBO(142, 142, 147, .15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Theme(
                child: TextField(
                  controller: controller,
                  onSubmitted: (v) {},
                  onChanged: onChanged,
                  style: TextStyle(
                    color: backgroundColor(SizeConfig.cntxt, invert: true),
                  ),
                  decoration: InputDecoration(
                    icon: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Icon(
                        Icons.search,
                        size: 22,
                        color: backgroundColor(SizeConfig.cntxt, invert: true),
                      ),
                    ),
                    border: InputBorder.none,
                    hintText: "Search here...",
                    hintStyle: TextStyle(
                      color: !SizeConfig.cntxt.isDarkMode()
                          ? const Color.fromRGBO(142, 142, 147, 1)
                          : Colors.white60,
                    ),
                  ),
                ),
                data: Theme.of(SizeConfig.cntxt).copyWith(
                  primaryColor: backgroundColor(SizeConfig.cntxt, invert: true),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 13,
        ),
      ],
    );
  }
}
