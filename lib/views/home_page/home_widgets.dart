import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:whatsapp_application/models/user.dart';
import 'package:whatsapp_application/views/status_page/status_page.dart';
import 'package:whatsapp_application/widgets/common_widgets.dart';
import '../../constants/colors.dart';
import '../../helper/size_config.dart';

Widget storyWidget(
    {required double size,
    required String imageUrl,
    required String text,
    bool showGreenStrip = false}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: Column(
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: showGreenStrip
                  ? null
                  : DecorationImage(
                      image: NetworkImage(imageUrl), fit: BoxFit.cover),
              border: showGreenStrip
                  ? Border.all(color: greenColor, width: 2)
                  : null),
          child: showGreenStrip
              ? Padding(
                  padding: EdgeInsets.all(showGreenStrip ? 2.2 : 0),
                  child: Container(
                    width: size,
                    height: size,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(imageUrl), fit: BoxFit.cover)),
                  ),
                )
              : null,
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: size,
          child: Center(
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: grayColor(SizeConfig.cntxt).lightShade),
            ),
          ),
        )
      ],
    ),
  );
}

Widget searchBar({required TextEditingController controller, ValueChanged<String>? onChanged}) {
  return Column(
    key: const ValueKey<int>(0),
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: SizeConfig.screenWidth,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            color: Color.fromRGBO(142, 142, 147, .15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Theme(
              child: TextField(
                controller: controller,
                onSubmitted: (v) {},
                onChanged: onChanged,
                style: TextStyle(
                    color: backgroundColor(SizeConfig.cntxt, invert: true)),
                decoration: InputDecoration(
                  icon: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Icon(
                      Icons.search,
                      size: 22,
                      color: backgroundColor(SizeConfig.cntxt, invert: true),
                    ),
                  ),
                  border: InputBorder.none,
                  hintText: "Search here...",
                  hintStyle: TextStyle(
                      color: !SizeConfig.cntxt.isDarkMode()
                          ? const Color.fromRGBO(142, 142, 147, 1)
                          : Colors.white60),
                ),
              ),
              data: Theme.of(SizeConfig.cntxt).copyWith(
                primaryColor: backgroundColor(SizeConfig.cntxt, invert: true),
              ),
            ),
          ),
        ),
      ),
      const SizedBox(
        height: 13,
      ),
    ],
  );
}

Widget statusBar(
    {required List<User> statusList, GestureTapCallback? onNewStatusClicked, addWidget = true, seeAllWidget = true}) {
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
                      child: gradientIconButton(
                          size: 60, iconData: Icons.add, text: "New Status"),
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
                  itemCount: statusList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(CupertinoPageRoute(
                            builder: (context) => const StatusPage()));
                      },
                      child: storyWidget(
                          size: 60,
                          showGreenStrip:
                              addWidget && (index == 2 || index == 3),
                          text: statusList[index].firstName +
                              " " +
                              statusList[index].lastName,
                          imageUrl: statusList[index].picture),
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
