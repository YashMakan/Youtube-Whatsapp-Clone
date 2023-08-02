import 'package:flutter/material.dart';
import 'package:whatsapp_redesign/constants/colors.dart';
import 'package:whatsapp_redesign/models/onboarding_page.dart';
import 'package:whatsapp_redesign/models/size_config.dart';

class AnimatedOnboardingImages extends StatefulWidget {
  final List<OnBoardingPageModel> pages;
  final bool showForm;
  final PageController? pageController;
  final double top;
  final double left;

  const AnimatedOnboardingImages(
      {super.key,
      required this.pages,
      required this.showForm,
      required this.pageController,
      required this.top,
      required this.left});

  @override
  State<AnimatedOnboardingImages> createState() =>
      _AnimatedOnboardingImagesState();
}

class _AnimatedOnboardingImagesState extends State<AnimatedOnboardingImages> {
  List<OnBoardingPageModel> get pages => widget.pages;

  bool get showForm => widget.showForm;

  PageController? get pageController => widget.pageController;

  double get top => widget.top;

  double get left => widget.left;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        !showForm
            ? Expanded(
                child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (value) {},
                  itemCount: pages.length,
                  controller: pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    OnBoardingPageModel page = pages[index];
                    return Column(
                      children: [
                        SizedBox(height: SizeConfig.screenHeight * 0.3),
                        AnimatedPadding(
                            padding: EdgeInsets.only(top: top, left: left),
                            duration: const Duration(seconds: 1),
                            child: ShaderMask(
                              blendMode: BlendMode.srcATop,
                              shaderCallback: (Rect bounds) {
                                return LinearGradient(colors: [
                                  greenGradient.lightShade,
                                  greenGradient.darkShade,
                                ]).createShader(bounds);
                              },
                              child: Image.network(
                                page.image,
                                width: 100,
                              ),
                            ))
                      ],
                    );
                  },
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
