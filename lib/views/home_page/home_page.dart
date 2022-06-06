import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:line_icons/line_icons.dart';
import 'package:whatsapp_application/models/user.dart';
import '../../constants/colors.dart';
import '../../constants/persons.dart';
import '../../widgets/common_widgets.dart';
import '../message_page/message_page.dart';
import 'home_widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.scrollController}) : super(key: key);

  final ScrollController scrollController;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isSearch = false;
  TextEditingController controller = TextEditingController();
  List<User> chats = [];
  List<User> statusList = [];

  // ignore: non_constant_identifier_names
  double SLIDABLE_WIDGET_WIDTH_RATIO = 0.25, SLIDABLE_ICON_SIZE = 30;

  @override
  void initState() {
    chats = persons.map((e) => User.fromJson(e)).toList();
    statusList = persons.map((e) => User.fromJson(e)).toList().reversed.toList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.transparent,
        child: gradientIconButton(
            size: 55, iconData: Icons.group_add),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 26,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      isSearch ? "Search" : "Chats",
                      style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w800,
                          color: blackColor(context).darkShade),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Transform.rotate(
                      angle: isSearch ? pi * (90 / 360) : 0,
                      child: IconButton(
                        icon:
                            Icon(isSearch ? Icons.add : Icons.search, size: 32),
                        splashRadius: 20,
                        onPressed: () {
                          setState(() {
                            isSearch = !isSearch;
                            controller.clear();
                          });
                        },
                        color: greenColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              isSearch
                  ? searchBar(controller: controller)
                  : statusBar(statusList: statusList)
            ],
          ),
          Expanded(
            child: isSearch && controller.text.trim().isNotEmpty
                ? Center(
                    child: customLoader(context),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.only(top: 10),
                    controller: widget.scrollController,
                    itemCount: chats.length,
                    separatorBuilder: (context, index) {
                      return const Divider(
                        thickness: 0.3,
                      );
                    },
                    itemBuilder: (context, index) => Slidable(
                      key: UniqueKey(),
                      startActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        extentRatio: SLIDABLE_WIDGET_WIDTH_RATIO,
                        dismissible: DismissiblePane(onDismissed: () {
                          setState(() {
                            chats.removeAt(index);
                          });
                        }),
                        children: [
                          CustomSlidableAction(
                            backgroundColor: greenColor,
                            onPressed: (BuildContext context) {},
                            child: Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                    greenGradient.lightShade,
                                    greenGradient.darkShade,
                                  ],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter)),
                              child: Center(
                                child: Icon(LineIcons.checkSquareAlt,
                                    color: Colors.white,
                                    size: SLIDABLE_ICON_SIZE),
                              ),
                            ),
                          )
                        ],
                      ),
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        extentRatio: (SLIDABLE_WIDGET_WIDTH_RATIO) * 2,
                        dismissible: DismissiblePane(onDismissed: () {}),
                        children: [
                          CustomSlidableAction(
                            onPressed: (_) {},
                            backgroundColor: grayColor(context).lightShade,
                            foregroundColor: Colors.white,
                            child: Icon(
                              Icons.more_horiz_outlined,
                              size: SLIDABLE_ICON_SIZE,
                            ),
                          ),
                          CustomSlidableAction(
                            onPressed: (_) {},
                            backgroundColor: const Color(0xFFE25C5C),
                            foregroundColor: Colors.white,
                            child: Icon(Icons.delete_outline,
                                size: SLIDABLE_ICON_SIZE),
                          ),
                        ],
                      ),
                      child: customListTile(
                          isOnline: index == 3 ? false : true,
                          imageUrl: chats[index].picture,
                          title:
                              "${chats[index].firstName} ${chats[index].lastName}",
                          subTitle: sentences[index],
                          messageCounter: index == 0 ? 3 : null,
                          onTap: () {
                            Navigator.of(context).push(CupertinoPageRoute(
                                builder: (context) => MessagePage(user: chats[index],)));
                          },
                          participantImages: index == 3
                              ? chats.map((chat) => chat.picture).toList()
                              : null,
                          customListTileType: index == 3
                              ? CustomListTileType.group
                              : CustomListTileType.message,
                          timeFrame: "16:32"),
                    ),
                  ),
          )
        ],
      )),
    );
  }
}
