import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:whatsapp_application/models/user.dart';
import 'package:whatsapp_application/views/settings_page/settings_widgets.dart';
import '../../constants/colors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isSearch = false;
  bool toggle = true;
  User? user;
  TextEditingController controller = TextEditingController();

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
                  image: user?.picture ?? "",
                  name: "Yash Makan",
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
                  onTap: () {}),
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
                  title: "Notifications",
                  settingTrailing: SettingTrailing.toggle,
                  onToggle: (value) {
                    setState(() {
                      toggle = value;
                    });
                  },
                  toggle: toggle,
                  iconData: LineIcons.bell),
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
              Column(
                children: [
                  settingTile(
                      title: "Settings",
                      settingTrailing: SettingTrailing.arrow,
                      iconData: LineIcons.cog),
                  settingTile(
                      title: "Share",
                      settingTrailing: SettingTrailing.arrow,
                      iconData: LineIcons.share),
                  settingTile(
                      title: "Change Password",
                      settingTrailing: SettingTrailing.arrow,
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
              Expanded(
                  child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'from',
                      style: TextStyle(
                          color: grayColor(context).lightShade.withOpacity(0.8),
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
              ))
            ],
          ),
        )));
  }
}
