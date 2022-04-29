import 'package:flutter/material.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:whatsapp_application/views/call_page/call_page.dart';
import 'package:whatsapp_application/views/settings_page/settings_page.dart';
import '../constants/colors.dart';
import 'home_page/home_page.dart';
import 'home_page/home_widgets.dart';

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int selectedIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor(context),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        backgroundColor: Colors.transparent,
        child: gradientIconButton(
            size: 55, iconData: Icons.group_add),
      ),
      body: getBody(),
      bottomNavigationBar: bottomNavigationBar()
    );
  }
  Widget getBody(){
    switch(selectedIndex){
      case 0:
        return const CallPage();
      case 1:
        return const HomePage();
      case 2:
        return const SettingsPage();
      default:
        return const HomePage();
    }
  }
  Widget bottomNavigationBar() {
    return CustomNavigationBar(
      iconSize: 24.0,
      selectedColor: Colors.white,
      strokeColor: Colors.white,
      unSelectedColor: const Color(0xff6c788a),
      backgroundColor: backgroundColor(context),
      items: [
        CustomNavigationBarItem(
          icon: Icon(Icons.phone, size: 24, color: selectedIndex == 0?greenColor:null,),
        ),
        CustomNavigationBarItem(
          icon: Icon(Icons.message, size: 24, color: selectedIndex == 1?greenColor:null,),
        ),
        CustomNavigationBarItem(
          icon: Icon(Icons.settings, size: 24, color: selectedIndex == 2?greenColor:null,),
        ),
      ],
      currentIndex: selectedIndex,
      onTap: (index) {
        setState(() {
          selectedIndex = index;
        });
      },
    );
  }
}
