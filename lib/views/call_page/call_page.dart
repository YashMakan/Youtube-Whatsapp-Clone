import 'dart:math';
import 'package:flutter/material.dart';
import 'package:whatsapp_application/constants/persons.dart';
import '../../constants/colors.dart';
import '../../widgets/common_widgets.dart';
import '../home_page/home_widgets.dart';

class CallPage extends StatefulWidget {
  const CallPage({Key? key, required this.scrollController}) : super(key: key);

  final ScrollController scrollController;

  @override
  _CallPageState createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
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
            size: 55, iconData: Icons.phone_forwarded, context: context),
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
                  ? searchBar(context: context, controller: controller)
                  : statusBar(
                      addWidget: false, seeAllWidget: false, context: context)
            ],
          ),
          Expanded(
            child: ListView.separated(
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
                  imageUrl: persons[index]['picture'].toString(),
                  title:
                      "${persons[index]['first_name']} ${persons[index]['last_name']}",
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
