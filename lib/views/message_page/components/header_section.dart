import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:whatsapp_application/views/message_page/components/profile_circular_widget.dart';

import '../../../constants/colors.dart';
import '../../../models/user.dart';
import '../../call_page/calling_page.dart';
import '../../profile_page/profile_page.dart';

class HeaderSection extends StatefulWidget {
  final User user;
  const HeaderSection({Key? key, required this.user}) : super(key: key);

  @override
  State<HeaderSection> createState() => _HeaderSectionState();
}

class _HeaderSectionState extends State<HeaderSection> {
  late User user;
  @override
  void initState() {
    user = widget.user;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(CupertinoPageRoute(
              builder: (context) => ProfilePage(
                user: user,
                profilePageStatus: ProfilePageStatus.view,
              )));
        },
        child: SizedBox(
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 26,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ProfileCircularWidget(image: user.picture),
                        const SizedBox(
                          width: 16,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.name,
                              style: TextStyle(
                                  color: blackColor(context).darkShade,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              "Online",
                              style: TextStyle(
                                  color: blackColor(context).lightShade,
                                  fontSize: 13),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(CupertinoPageRoute(
                                      builder: (context) => CallAcceptDeclinePage(
                                        user: user,
                                      )));
                                },
                                child: const Icon(
                                  LineIcons.phone,
                                  size: 27,
                                  color: greenColor,
                                )),
                            const SizedBox(
                              width: 16,
                            ),
                            GestureDetector(
                                onTap: () {},
                                child: const Icon(
                                  LineIcons.video,
                                  size: 27,
                                  color: greenColor,
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Divider(
                  thickness: 0.3,
                  height: 0,
                  color: grayColor(context).darkShade.withOpacity(0.5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
