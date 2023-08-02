import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:whatsapp_redesign/constants/colors.dart';
import 'package:whatsapp_redesign/models/size_config.dart';
import 'package:whatsapp_redesign/widgets/gradient_text.dart';

class LottieAnimationStackWidget extends StatelessWidget {
  final bool showForm;
  final bool onOTPage;
  final bool isKeyboardOpened;

  const LottieAnimationStackWidget(
      {super.key,
      required this.showForm,
      required this.onOTPage,
      required this.isKeyboardOpened});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        showForm && !isKeyboardOpened
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: onOTPage
                            ? SizeConfig.screenHeight * 0.15
                            : SizeConfig.screenHeight * 0.05,
                      ),
                      onOTPage
                          ? Lottie.asset("assets/lock.json",
                              height: 150.0, width: 150, repeat: false)
                          : ShaderMask(
                              blendMode: BlendMode.srcIn,
                              shaderCallback: (bounds) => LinearGradient(
                                  colors: [
                                    greenGradient.darkShade,
                                    greenGradient.lightShade
                                  ]).createShader(
                                Rect.fromLTWH(
                                    0, 0, bounds.width, bounds.height),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Lottie.asset("assets/wave.json",
                                    height: 300.0, repeat: false),
                              ),
                            ),
                    ],
                  ),
                ],
              )
            : const SizedBox(),
        showForm && !isKeyboardOpened
            ? SizedBox(
                width: SizeConfig.screenWidth,
                child: Column(
                  children: [
                    SizedBox(
                      height: SizeConfig.screenHeight * 0.35,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GradientText(
                          onOTPage ? "Enter the OTP" : "Welcome!",
                          style: const TextStyle(
                              fontSize: 36, fontWeight: FontWeight.bold),
                          gradient: LinearGradient(colors: [
                            greenGradient.lightShade,
                            greenGradient.darkShade,
                          ]),
                        ),
                      ],
                    )
                  ],
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
