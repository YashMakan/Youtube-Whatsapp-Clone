import 'dart:async';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_redesign/managers/navigation_manager/navigation_manager.dart';
import 'package:whatsapp_redesign/models/onboarding_page.dart';

class AuthProvider extends ChangeNotifier {
  double top = 0, left = 0;
  Timer? timer;
  PageController? pageController;
  int selectedPageIndex = 0;
  bool showForm = false;
  bool onOTPage = false;

  OnBoardingPageModel get page => pages[selectedPageIndex];

  List<OnBoardingPageModel> pages = [
    OnBoardingPageModel(
        "https://cdn-icons-png.flaticon.com/512/2103/2103620.png",
        "Connect With Anyone\nIn Any Form",
        "Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mollitia, molestiae quas vel sint commodi repudiandae."),
    OnBoardingPageModel(
        "https://cdn-icons-png.flaticon.com/512/77/77087.png",
        "Complete Safety With\nFull Privacy",
        "Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mollitia, molestiae quas vel sint commodi repudiandae."),
    OnBoardingPageModel(
        "https://cdn-icons-png.flaticon.com/512/1189/1189175.png",
        "Share With Your\nLoved Ones",
        "Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mollitia, molestiae quas vel sint commodi repudiandae."),
  ];

  String? verificationId;
  FirebaseAuth auth = FirebaseAuth.instance;

  void timerDispose() {
    timer?.cancel();
  }

  startFloatingAnimation() {
    timerDispose();
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      int threshold = 20;
      top = Random().nextInt(threshold).toDouble(); // 0-20
      left = Random().nextInt(threshold).toDouble(); // 0-20
    });
  }

  void initialize() {
    startFloatingAnimation();
    pageController = PageController(initialPage: selectedPageIndex);
    notifyListeners();
  }

  void onLeftArrowClicked() {
    if (selectedPageIndex != 0) {
      if (pages.length - 1 == selectedPageIndex) {
        selectedPageIndex = 0;
        showForm = false;
      } else {
        pageController!.animateToPage(selectedPageIndex - 1,
            curve: Curves.fastLinearToSlowEaseIn,
            duration: const Duration(seconds: 2));
        selectedPageIndex--;
      }
    }
    notifyListeners();
  }

  void onRightArrowClicked() {
    if (selectedPageIndex != pages.length) {
      if (pages.length - 1 == selectedPageIndex) {
        showForm = true;
      } else {
        pageController!.animateToPage(selectedPageIndex + 1,
            curve: Curves.fastLinearToSlowEaseIn,
            duration: const Duration(seconds: 2));
        selectedPageIndex++;
      }
    }
    notifyListeners();
  }

  void onLeftArrowReset(isKeyboardOpened) {
    if (isKeyboardOpened) {
      FocusManager.instance.primaryFocus?.unfocus();
      return;
    }
    if (onOTPage) {
      onOTPage = false;
    } else if (showForm) {
      showForm = false;
      selectedPageIndex = 0;
    }
    notifyListeners();
  }

  void onSendOtpClicked(phoneNumber) {
    onOTPage = true;
    auth.verifyPhoneNumber(
        phoneNumber: "+91$phoneNumber",
        timeout: const Duration(minutes: 2),
        verificationCompleted: (authCredential) {
          print("VERIFIED: ${authCredential.smsCode}");
        },
        verificationFailed: (authException) {
          print("ERROR: ${authException.message}");
        },
        codeSent: (id, _) {
          print("ID SEND $id");
          verificationId = id;
        },
        codeAutoRetrievalTimeout: (id) {
          print("Code expired: $id");
        });
    notifyListeners();
  }

  void onOtpSubmit(otp, context) {
    // verify otp function
    if (verificationId == null) {
      throw Exception("VerificationId cannot be null");
    }
    final credential = PhoneAuthProvider.credential(
        verificationId: verificationId!, smsCode: otp);
    auth.signInWithCredential(credential).then((result) {
      print("User verified");
      NavigationManager.navigate(context, Routes.rootScreen);
    }).catchError((e) {
      print(e);
    });
  }

}
