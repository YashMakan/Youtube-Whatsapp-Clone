import 'dart:ui';

class DoubleShade{
  final Color lightShade;
  final Color darkShade;

  DoubleShade(this.lightShade, this.darkShade);
}

const Color backgroundColor = Color(0xFFFFFFFF);
const Color greenColor = Color(0xFF5CE27F);
const Color yellowColor = Color(0xFFFFE12D);
const Color redColor = Color(0xFFE25C5C);
DoubleShade greenGradient = DoubleShade(Color(0xFF5CE27F), Color(0xFF5CABE2));
DoubleShade blackColor = DoubleShade(Color(0xFF313131), Color(0xFF121212));
DoubleShade grayColor = DoubleShade(Color(0xFFB1B1B1), Color(0xFFEFEFEF));