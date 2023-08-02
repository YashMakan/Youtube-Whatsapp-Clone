import 'package:flutter/material.dart';
import 'package:whatsapp_redesign/views/onboarding_page/onboarding_page.dart';
import 'package:whatsapp_redesign/views/root_page.dart';
import 'package:whatsapp_redesign/views/splash_page/splash_page.dart';

class Routes {
  static const String initial = '/';
  static const String splashScreen = 'splash_screen';
  static const String onboardingScreen = 'onboarding_screen';
  static const String rootScreen = 'root_screen';
}

class NavigationManager {
  static Map<String, Widget Function(BuildContext)> routes = {
    Routes.initial: (context) => const SplashScreen(),
    Routes.splashScreen: (context) => const SplashScreen(),
    Routes.onboardingScreen: (context) => const OnBoardingPage(),
    Routes.rootScreen: (context) => const RootPage()
  };

  static Future<dynamic> navigate(BuildContext context, String route,
      {Object? argument, bool replace = false}) async {
    if (replace) {
      return await Navigator.of(context)
          .pushReplacementNamed(route, arguments: argument);
    } else {
      return await Navigator.of(context).pushNamed(route, arguments: argument);
    }
  }
}
