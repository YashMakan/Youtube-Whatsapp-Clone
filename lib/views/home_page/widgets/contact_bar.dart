import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:whatsapp_redesign/constants/colors.dart';
import 'package:whatsapp_redesign/views/home_page/widgets/selected_contact_widget.dart';
import 'package:whatsapp_redesign/views/status_page/status_page.dart';
import 'package:whatsapp_redesign/widgets/gradient_icon_button.dart';

class ContactBar extends StatelessWidget {
  final List<Contact> contactList;
  final GestureTapCallback? onNewStatusClicked;
  final bool addWidget;
  final bool seeAllWidget;

  const ContactBar({
    Key? key,
    required this.contactList,
    this.onNewStatusClicked,
    this.addWidget = true,
    this.seeAllWidget = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const ValueKey<int>(1),
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: SizedBox(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 16),
              children: [
                addWidget
                    ? GestureDetector(
                  onTap: onNewStatusClicked,
                  child: const GradientIconButton(
                    size: 60,
                    iconData: Icons.add,
                    text: "New Status",
                  ),
                )
                    : const SizedBox(),
                addWidget
                    ? const SizedBox(
                  width: 8,
                )
                    : const SizedBox(),
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: contactList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(CupertinoPageRoute(
                            builder: (context) => const StatusPage(),
                          ));
                        },
                        child: SelectedContactWidget(
                          size: 60,
                          user: contactList[index],
                        ),
                      );
                    },
                  ),
                ),
                seeAllWidget
                    ? const SizedBox(
                  width: 10,
                )
                    : const SizedBox(),
                seeAllWidget
                    ? const Icon(
                  LineIcons.arrowRight,
                  color: greenColor,
                )
                    : const SizedBox(),
                seeAllWidget
                    ? const SizedBox(
                  width: 10,
                )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Divider(
          height: 0,
          thickness: 0.6,
        ),
      ],
    );
  }
}
