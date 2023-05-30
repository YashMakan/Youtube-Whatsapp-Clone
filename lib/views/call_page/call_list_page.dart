import 'dart:math';
import 'package:flutter/material.dart';
import 'package:whatsapp_application/constants/colors.dart';
import 'package:whatsapp_application/constants/enums.dart';
import 'package:whatsapp_application/constants/persons.dart';
import 'package:whatsapp_application/models/user.dart';
import 'package:whatsapp_application/views/home_page/widgets/search_bar.dart';
import 'package:whatsapp_application/views/home_page/widgets/status_bar.dart';
import 'package:whatsapp_application/widgets/custom_listtile.dart';
import 'package:whatsapp_application/widgets/gradient_icon_button.dart';

class CallListPage extends StatefulWidget {
  const CallListPage({Key? key, required this.scrollController})
      : super(key: key);

  final ScrollController scrollController;

  @override
  _CallListPageState createState() => _CallListPageState();
}

class _CallListPageState extends State<CallListPage> {
  bool isSearch = false;
  TextEditingController controller = TextEditingController();
  List<User> users = [];

  @override
  void initState() {
    users = persons.map((e) => User.fromJson(e)).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.transparent,
        child:
            const GradientIconButton(size: 55, iconData: Icons.phone_forwarded),
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
                      "Calls",
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
                  ? SearchBar(controller: controller)
                  : StatusBar(
                      addWidget: false, seeAllWidget: false, statusList: users)
            ],
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.only(top: 10),
              controller: widget.scrollController,
              itemCount: users.length,
              separatorBuilder: (context, index) {
                return const Divider(
                  thickness: 0.3,
                );
              },
              itemBuilder: (context, index) => CustomListTile(
                  imageUrl: users[index].picture,
                  title: "${users[index].firstName} ${users[index].lastName}",
                  subTitle: "May 7, 6:29 PM",
                  onTap: () {},
                  numberOfCalls: 2,
                  customListTileType: CustomListTileType.call,
                  callStatus: CallStatus.accepted),
            ),
          )
        ],
      )),
    );
  }
}
