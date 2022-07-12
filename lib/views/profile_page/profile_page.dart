import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:whatsapp_application/models/user.dart';
import '../../constants/colors.dart';
import 'main_profile_page_widgets.dart';

enum ProfilePageStatus { view, personal }

class ProfilePage extends StatefulWidget {
  const ProfilePage(
      {Key? key, required this.user, required this.profilePageStatus})
      : super(key: key);

  final User user;
  final ProfilePageStatus profilePageStatus;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool toggle = true;
  late User user;
  List<IconData> icons = [
    LineIcons.phone,
    LineIcons.video,
    LineIcons.search,
    LineIcons.indianRupeeSign,
  ];
  List images = List.generate(
      17,
      (index) =>
          "https://images.unsplash.com/photo-1588938172737-f774f5476d2d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80");
  int selectedGender = 0;

  @override
  void initState() {
    user = widget.user;
    super.initState();
  }

  Widget getBody() {
    switch (widget.profilePageStatus) {
      case ProfilePageStatus.view:
        return SafeArea(
            child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 22.0, right: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {},
                        padding: EdgeInsets.zero,
                        splashRadius: 26,
                        constraints:
                            const BoxConstraints(maxHeight: 27, maxWidth: 27),
                        icon: Icon(
                          LineIcons.arrowLeft,
                          color: blackColor(context).lightShade,
                        )),
                    IconButton(
                        onPressed: () {},
                        padding: EdgeInsets.zero,
                        splashRadius: 26,
                        constraints:
                            const BoxConstraints(maxHeight: 27, maxWidth: 27),
                        icon: Icon(
                          LineIcons.verticalEllipsis,
                          color: blackColor(context).lightShade,
                        ))
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(user.picture), fit: BoxFit.cover)),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                user.name,
                style: TextStyle(
                    color: blackColor(context).darkShade,
                    fontSize: 24,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    user.phoneNumber,
                    style: TextStyle(
                        color: blackColor(context).lightShade,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  const Icon(
                    LineIcons.userCheck,
                    color: greenColor,
                    size: 16,
                  )
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                      icons.length,
                      (index) => Padding(
                            padding: EdgeInsets.only(
                                right: index != icons.length - 1 ? 14.0 : 0),
                            child: Container(
                              decoration: const BoxDecoration(
                                  color: Color(0xFF262831),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12))),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Icon(
                                  icons[index],
                                  size: 16,
                                  color: blackColor(context).lightShade,
                                ),
                              ),
                            ),
                          ))),
              const SizedBox(
                height: 16,
              ),
              Divider(
                thickness: 0.3,
                indent: 100,
                endIndent: 100,
                color: grayColor(context).darkShade.withOpacity(0.6),
              ),
              const SizedBox(
                height: 16,
              ),
              settingTile(
                  title: "Mute Notifications",
                  settingTrailing: SettingTrailing.toggle,
                  onToggle: (value) {
                    setState(() {
                      toggle = value;
                    });
                  },
                  toggle: toggle,
                  iconData: LineIcons.bell),
              const SizedBox(
                height: 32,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 22.0, bottom: 10),
                child: Row(
                  children: [
                    Text(
                      "MEDIA",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: grayColor(context).lightShade),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 250,
                child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(left: 22),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10),
                    itemCount: images.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        decoration: BoxDecoration(
                            color: const Color(0xFF262831),
                            borderRadius: BorderRadius.circular(22)),
                      );
                    }),
              ),
              const SizedBox(
                height: 16,
              ),
              Column(
                children: [
                  settingTile(
                      title: "Block ${user.name}",
                      shouldRedGlow: true,
                      iconData: LineIcons.ban),
                  settingTile(
                      title: "Report ${user.name}",
                      shouldRedGlow: true,
                      iconData: LineIcons.thumbsDown),
                ],
              ),
            ],
          ),
        ));
      case ProfilePageStatus.personal:
        return SafeArea(
            child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 22.0),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        padding: EdgeInsets.zero,
                        splashRadius: 26,
                        constraints:
                            const BoxConstraints(maxHeight: 27, maxWidth: 27),
                        icon: Icon(
                          LineIcons.arrowLeft,
                          color: blackColor(context).lightShade,
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(user.picture), fit: BoxFit.cover)),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                user.name,
                style: TextStyle(
                    color: blackColor(context).darkShade,
                    fontSize: 24,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    user.phoneNumber,
                    style: TextStyle(
                        color: blackColor(context).lightShade,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  const Icon(
                    LineIcons.userCheck,
                    color: greenColor,
                    size: 16,
                  )
                ],
              ),
              const SizedBox(
                height: 32,
              ),
              customListTile("full name"),
              const SizedBox(height: 16),
              customListTile("about"),
              const SizedBox(height: 16),
              customListTile("email"),
              const SizedBox(height: 16),
              customMultiChoice(
                  "gender", ["male", "female", "other"], selectedGender,
                  (index) {
                setState(() {
                  selectedGender = index;
                });
              }),
              const SizedBox(height: 16),
              Column(
                children: [
                  settingTile(
                      title: "Logout",
                      shouldRedGlow: true,
                      iconData: LineIcons.alternateSignOut),
                  settingTile(
                      title: "Delete Account",
                      shouldRedGlow: true,
                      iconData: LineIcons.ban),
                ],
              ),
            ],
          ),
        ));
    }
  }

  Widget customMultiChoice(String heading, List<String> choices, int selected,
      ValueChanged<int> onSelect) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 22.0, bottom: 10),
          child: Row(
            children: [
              Text(
                heading.toUpperCase(),
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: grayColor(context).lightShade),
              )
            ],
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width - 44,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                  choices.length,
                  (index) => InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: () {
                          onSelect(index);
                        },
                        child: Container(
                          width: ((MediaQuery.of(context).size.width - 44) /
                                  choices.length) -
                              10,
                          height: 50,
                          child: Center(
                            child: Text(
                              choices[index].toUpperCase(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: selected == index
                                      ? backgroundColor(context)
                                      : blackColor(context).lightShade),
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: selected == index
                                  ? greenColor
                                  : const Color(0xFF262831),
                              borderRadius: BorderRadius.circular(8)),
                        ),
                      ))),
        ),
      ],
    );
  }

  Widget customListTile(String heading) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 22.0, bottom: 10),
          child: Row(
            children: [
              Text(
                heading.toUpperCase(),
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: grayColor(context).lightShade),
              )
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width - 44,
          height: 50,
          decoration: BoxDecoration(
              color: const Color(0xFF262831),
              borderRadius: BorderRadius.circular(8)),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: backgroundColor(context), body: getBody());
  }
}
