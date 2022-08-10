import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:line_icons/line_icons.dart';
import 'package:whatsapp_application/main.dart';
import 'package:whatsapp_application/models/user.dart';
import '../../constants/colors.dart';
import '../../constants/persons.dart';
import '../../widgets/common_widgets.dart';
import '../contact_page/contact_page.dart';
import '../message_page/message_page.dart';
import 'home_widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, this.scrollController}) : super(key: key);

  final ScrollController? scrollController;

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
    chats.insert(0, rick);
    statusList =
        persons.map((e) => User.fromJson(e)).toList().reversed.toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor(context),
      floatingActionButton: !isSearch
          ? FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(CupertinoPageRoute(
                    builder: (context) => const ContactPage()));
              },
              backgroundColor: Colors.transparent,
              child: gradientIconButton(size: 55, iconData: Icons.group_add),
            )
          : const SizedBox(),
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
                    child: IconButton(
                      icon:
                          Icon(isSearch ? Icons.close : Icons.search, size: 32),
                      splashRadius: 20,
                      onPressed: () {
                        setState(() {
                          if (isSearch) {
                            isSearch = false;
                          }
                          controller.clear();
                        });
                      },
                      color: greenColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              isSearch
                  ? searchBar(controller: controller)
                  : statusBar(
                      statusList: statusList,
                      onNewStatusClicked: () async {
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
                                              fixedSize:
                                                  MaterialStateProperty.all(
                                                      const Size(150, 30)),
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      greenColor)),
                                          onPressed: () {},
                                        ),
                                        ElevatedButton(
                                          child: const Text('Cancel',
                                              style:
                                                  TextStyle(color: greenColor)),
                                          style: ButtonStyle(
                                              fixedSize:
                                                  MaterialStateProperty.all(
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
//                final ImagePicker _picker = ImagePicker();
//                final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                      })
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
                            child: Center(
                              child: Icon(LineIcons.userSecret,
                                  color: Colors.white,
                                  size: SLIDABLE_ICON_SIZE),
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
                                builder: (context) => MessagePage(
                                      user: chats[index],
                                    )));
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
