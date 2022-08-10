import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:passcode_screen/passcode_screen.dart';
import 'package:share_plus/share_plus.dart';
import 'package:whatsapp_application/helper/size_config.dart';
import 'package:whatsapp_application/main.dart';
import 'package:whatsapp_application/views/profile_page/profile_page.dart';
import 'package:whatsapp_application/views/profile_page/settings_page.dart';
import '../../constants/colors.dart';
import 'main_profile_page_widgets.dart';

class MainProfilePage extends StatefulWidget {
  const MainProfilePage({Key? key, required this.scrollController})
      : super(key: key);

  final ScrollController scrollController;

  @override
  _MainProfilePageState createState() => _MainProfilePageState();
}

class _MainProfilePageState extends State<MainProfilePage> {
  bool toggle = true;
  final StreamController<bool> _verificationNotifier = StreamController<bool>.broadcast();
  @override
  void dispose() {
    _verificationNotifier.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor(context),
        body: SafeArea(
            child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 35,
              ),
              profileWidget(
                  image: user.picture,
                  name: user.name,
                  onLogoutClick: () {
                    showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (context) {
                          return Container(
                            margin: const EdgeInsets.only(
                                left: 25, right: 25, bottom: 70),
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 20),
                            decoration: BoxDecoration(
                                color: context.isDarkMode()
                                    ? Colors.black26
                                    : Colors.white,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10))),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Are you sure to logout ?",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: blackColor(context).darkShade,
                                      fontSize: 19),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                ButtonBar(
                                  buttonPadding: EdgeInsets.zero,
                                  alignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    ElevatedButton(
                                      child: const Text(
                                        'Yes, log out!',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      style: ButtonStyle(
                                          fixedSize: MaterialStateProperty.all(
                                              const Size(150, 30)),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  greenColor)),
                                      onPressed: () {},
                                    ),
                                    ElevatedButton(
                                      child: const Text('Cancel',
                                          style: TextStyle(color: greenColor)),
                                      style: ButtonStyle(
                                          fixedSize: MaterialStateProperty.all(
                                              const Size(100, 30)),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  backgroundColor(context)),
                                          side: MaterialStateProperty.all(
                                              const BorderSide(
                                                  color: greenColor))),
                                      onPressed: () {},
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        });
                  },
                  onTap: () {
                    Navigator.of(context).push(CupertinoPageRoute(
                        builder: (context) => ProfilePage(
                              user: user,
                              profilePageStatus: ProfilePageStatus.personal,
                            )));
                  }),
              const SizedBox(
                height: 20,
              ),
              Divider(
                thickness: 0.3,
                indent: 100,
                endIndent: 100,
                color: grayColor(context).darkShade.withOpacity(0.6),
              ),
              const SizedBox(
                height: 10,
              ),
              settingTile(
                  title: "Do Not Disturb",
                  settingTrailing: SettingTrailing.toggle,
                  onToggle: (value) {
                    setState(() {
                      toggle = value;
                    });
                  },
                  toggle: toggle,
                  iconData: Icons.do_not_disturb),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 22.0, bottom: 10),
                child: Row(
                  children: [
                    Text(
                      "MANAGE",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: grayColor(context).lightShade),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.45,
                child: Scrollbar(
                  isAlwaysShown: true,
                  thickness: 2,
                  hoverThickness: 4,
                  interactive: true,
                  showTrackOnHover: true,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        settingTile(
                            title: "Settings",
                            onTap: (){
                              Navigator.of(context).push(CupertinoPageRoute(
                                  builder: (context) => const SettingsPage()));
                            },
                            settingTrailing: SettingTrailing.arrow,
                            iconData: LineIcons.cog),
                        settingTile(
                            title: "Private",
                            settingTrailing: SettingTrailing.arrow,
                            iconData: LineIcons.userSecret),
                        settingTile(
                            title: "Share",
                            settingTrailing: SettingTrailing.arrow,
                            onTap: () {
                              Share.share(
                                  "Let's chat on WhatsApp! It's a fast, simple, and secure app we can use to message and call each other for free. Get it at https://whatsapp.com/dl/");
                            },
                            iconData: LineIcons.share),
                        settingTile(
                            title: "Change Password",
                            settingTrailing: SettingTrailing.arrow,
                            onTap: (){
                              Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    opaque: false,
                                    pageBuilder: (context, animation, secondaryAnimation) =>
                                        PasscodeScreen(
                                          title: const Text(
                                            'Enter App Passcode',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(color: Colors.white, fontSize: 28),
                                          ),
                                          passwordEnteredCallback: (String enteredPassword){
                                            bool isValid = '1234' == enteredPassword;
                                            _verificationNotifier.add(isValid);
                                          },
                                          cancelButton: const Text(
                                            'Cancel',
                                            style: TextStyle(fontSize: 16, color: Colors.white),
                                            semanticsLabel: 'Cancel',
                                          ),
                                          deleteButton: const Text(
                                            'Delete',
                                            style: TextStyle(fontSize: 16, color: Colors.white),
                                            semanticsLabel: 'Delete',
                                          ),
                                          backgroundColor: Colors.black.withOpacity(0.8),
                                          cancelCallback: (){
                                            Navigator.pop(context);
                                          },
                                          passwordDigits: 4,
                                          shouldTriggerVerification: _verificationNotifier.stream,
                                        ),
                                  ));
                            },
                            iconData: LineIcons.lock),
                        settingTile(
                            title: "FAQ",
                            settingTrailing: SettingTrailing.arrow,
                            iconData: Icons.question_answer_outlined),
                        settingTile(
                            title: "Help",
                            settingTrailing: SettingTrailing.arrow,
                            iconData: Icons.help_outline),
                        settingTile(
                            title: "Invite a friend",
                            settingTrailing: SettingTrailing.arrow,
                            iconData: LineIcons.users),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'from',
                        style: TextStyle(
                            color:
                                grayColor(context).lightShade.withOpacity(0.8),
                            fontSize: 13),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            LineIcons.infinity,
                            size: 24,
                            color: greenColor,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Meta",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: backgroundColor(context, invert: true)),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        )));
  }
}
