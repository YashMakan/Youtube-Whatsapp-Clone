import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_redesign/getit.dart';
import 'package:whatsapp_redesign/models/size_config.dart';
import 'package:whatsapp_redesign/provider/auth_provider.dart';
import 'package:whatsapp_redesign/views/onboarding_page/widgets/animated_bottom_container.dart';
import 'package:whatsapp_redesign/views/onboarding_page/widgets/animated_onboarding_images.dart';
import 'package:whatsapp_redesign/views/onboarding_page/widgets/lottie_animation_stack_widget.dart';
import '../../constants/colors.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  AuthProvider? provider;

  @override
  void dispose() {
    provider?.timerDispose();
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider = Provider.of<AuthProvider>(context, listen: false);
      provider?.initialize();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    bool isKeyboardOpened = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      backgroundColor: backgroundColor(context),
      body: Consumer<AuthProvider>(builder: (context, provider, child) {
        return Stack(
          children: [
            LottieAnimationStackWidget(
              showForm: provider.showForm,
              onOTPage: provider.onOTPage,
              isKeyboardOpened: isKeyboardOpened,
            ),
            AnimatedOnboardingImages(
                pages: provider.pages,
                showForm: provider.showForm,
                pageController: provider.pageController,
                top: provider.top,
                left: provider.left),
            AnimatedBottomContainer(
                showForm: provider.showForm,
                onOTPage: provider.onOTPage,
                page: provider.page,
                selectedPageIndex: provider.selectedPageIndex,
                onLeftArrowClicked: provider.onLeftArrowClicked,
                onRightArrowClicked: provider.onRightArrowClicked,
                onLeftArrowReset: () => provider.onLeftArrowReset(isKeyboardOpened),
                onSendOtpClicked: provider.onSendOtpClicked,
                onOtpSubmit: (phoneNumber, otp) => provider.onOtpSubmit(phoneNumber, otp, context))
          ],
        );
      }),
    );
  }
}
