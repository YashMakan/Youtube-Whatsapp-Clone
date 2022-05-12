import 'package:flutter/material.dart';
import 'package:whatsapp_application/views/root_page.dart';

void main() {
  runApp(const MyApp());
}

class ScrollGlowEffect extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Whatsapp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: "SFProText"
      ),
      builder: (context, child) {
        return ScrollConfiguration(behavior: ScrollGlowEffect(), child: child!);
      },
      home: const RootPage(),
    );
  }
}
