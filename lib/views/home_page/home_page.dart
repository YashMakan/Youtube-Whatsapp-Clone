import 'package:flutter/material.dart';
import 'package:whatsapp_application/constants/persons.dart';
import '../../constants/colors.dart';
import '../../widgets/widgets.dart';
import 'home_widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor(context),
        floatingActionButton: FloatingActionButton(
          onPressed: (){},
          backgroundColor: Colors.transparent,
          child: gradientIconButton(
              size: 55, iconData: Icons.group_add),
        ),
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 32,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      "Chats",
                      style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800, color: blackColor(context).darkShade),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 16.0),
                    child: Icon(
                      Icons.search,
                      size: 32,
                      color: greenColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 26,
              ),
              const Divider(
                thickness: 0.6,
              ),
              Padding(
                padding:
                const EdgeInsets.only(left: 16.0, top: 12.0, bottom: 12.0),
                child: SizedBox(
                  height: 100,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      gradientIconButton(
                          size: 60, iconData: Icons.add, text: "New Status"),
                      const SizedBox(
                        width: 8,
                      ),
                      SizedBox(
                        height: 100,
                        child: ListView(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          children: List.generate(
                              persons.length,
                                  (index) => storyWidget(
                                  size: 60,
                                  showGreenStrip: index == 2 || index == 3,
                                  text: persons.reversed.toList()[index]['title'].toString(),
                                  imageUrl: persons.reversed.toList()[index]['picture'].toString()
                              )),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const Divider(
                thickness: 0.6,
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: persons.length,
                  physics: const BouncingScrollPhysics(),
                  separatorBuilder: (context, index){
                    return const Divider(thickness: 0.3,);
                  },
                  itemBuilder: (context, index) => homeListTile(
                      context: context,
                      isOnline: index==3?false:true,
                      imageUrl: persons[index]['picture'].toString(),
                      title: "${persons[index]['first_name']} ${persons[index]['last_name']}",
                      subTitle: "Bro, these are fire 🔥🔥",
                      messageCounter: 4,
                      participantImages: index==3?persons.map((e) => e['picture'].toString()).toList():null,
                      tiles: index == 3?homeTiles.group:homeTiles.message,
                      timeFrame: "16:32"),
                ),
              )
            ],
          ),
        ),
    );
  }
}
