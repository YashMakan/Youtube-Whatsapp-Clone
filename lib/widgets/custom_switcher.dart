import 'package:flutter/material.dart';

class CustomSwitcher extends StatelessWidget {
  final bool cond;
  final Widget child;
  final Widget? child2;

  const CustomSwitcher(
      {super.key, required this.cond, required this.child, this.child2});

  @override
  Widget build(BuildContext context) {
    return cond ? child : (child2 != null ? child2! : const SizedBox());
  }
}
