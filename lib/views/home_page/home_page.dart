import 'dart:math';
import 'package:flutter/material.dart';
import 'package:whatsapp_application/constants/persons.dart';
import '../../constants/colors.dart';
import '../../widgets/common_widgets.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.transparent,
        child: gradientIconButton(
            size: 55, iconData: Icons.group_add, context: context),
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
                  ? searchBar(context: context, controller: controller)
                  : statusBar(context: context)
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
                    itemCount: persons.length,
                    separatorBuilder: (context, index) {
                      return const Divider(
                        thickness: 0.3,
                      );
                    },
                    itemBuilder: (context, index) => customListTile(
                        context: context,
                        isOnline: index == 3 ? false : true,
                        imageUrl: persons[index]['picture'].toString(),
                        title:
                            "${persons[index]['first_name']} ${persons[index]['last_name']}",
                        subTitle: sentences[index],
                        messageCounter: index == 0 ? 3 : null,
                        onTap: () {},
                        participantImages: index == 3
                            ? persons
                                .map((e) => e['picture'].toString())
                                .toList()
                            : null,
                        customListTileType: index == 3
                            ? CustomListTileType.group
                            : CustomListTileType.message,
                        timeFrame: "16:32"),
                  ),
          )
        ],
      )),
    );
  }
}
