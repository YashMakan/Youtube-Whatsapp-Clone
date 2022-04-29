import 'dart:ui';

import 'package:flutter/material.dart';

class DoubleShade {
  final Color lightShade;
  final Color darkShade;

  DoubleShade(this.lightShade, this.darkShade);
}

extension DarkMode on BuildContext {
  bool isDarkMode() {
    final brightness = MediaQuery.of(this).platformBrightness;
    return brightness == Brightness.dark;
  }
}

Color backgroundColor(BuildContext context) => context.isDarkMode()
    ? Colors.black87
    : const Color(0xFFFFFFFF);

DoubleShade blackColor(BuildContext context) =>
    context.isDarkMode()
        ? DoubleShade(Colors.white60, Colors.white)
        : DoubleShade(const Color(0xFF313131), const Color(0xFF121212));

const Color greenColor = Color(0xFF5CE27F);
const Color yellowColor = Color(0xFFFFE12D);
const Color redColor = Color(0xFFE25C5C);

DoubleShade greenGradient =
    DoubleShade(const Color(0xFF5CE27F), const Color(0xFF5CABE2));

DoubleShade grayColor =
    DoubleShade(const Color(0xFFB1B1B1), const Color(0xFFEFEFEF));
