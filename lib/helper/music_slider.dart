import 'package:flutter/material.dart';

class MusicSlider extends StatefulWidget {
  final Color emptyColor;
  final Color fillColor;
  final double height;
  final int division;

  const MusicSlider(
      {Key? key,
      required this.emptyColor,
      required this.fillColor,
      required this.height,
      required this.division})
      : super(key: key);

  @override
  _MusicSliderState createState() => _MusicSliderState();
}

class _MusicSliderState extends State<MusicSlider> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
