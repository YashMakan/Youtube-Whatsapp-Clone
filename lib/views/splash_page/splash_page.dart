import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:whatsapp_application/constants/colors.dart';
import 'package:whatsapp_application/helper/size_config.dart';
import 'package:whatsapp_application/views/onboarding_page/onboarding_page.dart';
import 'package:whatsapp_application/widgets/common_widgets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (builder) => const OnBoardingPage()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    "assets/images/logo.png",
                    height: 100.0,
                    width: 100.0,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GradientText(
                  "WhatsApp",
                  style: const TextStyle(
                    fontSize: 28,
                  ),
                  gradient: LinearGradient(colors: [
                    greenGradient.lightShade,
                    greenGradient.darkShade,
                  ]),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'from',
                style: TextStyle(
                    color: grayColor(context).lightShade.withOpacity(0.4),
                    fontSize: 16),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    LineIcons.infinity,
                    size: 32,
                    color: greenColor,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Meta",
                    style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w800,
                        color: grayColor(context).lightShade),
                  )
                ],
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.12,
              )
            ],
          )
        ],
      ),
    );
  }
}
