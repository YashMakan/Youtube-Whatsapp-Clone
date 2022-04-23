import 'package:flutter/material.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/views/home/home_widgets.dart';
import 'package:flutter_app/widgets/widgets.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
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
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Icon(
                    Icons.group_add,
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
              child: Container(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    addStoryWidget(
                        size: 60, iconData: Icons.add, text: "New Status"),
                    SizedBox(
                      width: 8,
                    ),
                    Container(
                      height: 100,
                      child: ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        children: List.generate(
                            5,
                            (index) => storyWidget(
                                size: 60,
                                showGreenStrip: true,
                                text: "James Arthur",
                                imageUrl:
                                    "https://images.unsplash.com/photo-1592561199818-6b69d3d1d6e2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=988&q=80")),
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
                itemCount: 7,
                physics: BouncingScrollPhysics(),
                separatorBuilder: (context, index){
                  return Divider(thickness: 0.3,);
                },
                itemBuilder: (context, index) => messageListTile(
                    context: context,
                    isOnline: true,
                    imageUrl:
                        "https://images.unsplash.com/photo-1592561199818-6b69d3d1d6e2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=988&q=80",
                    title: "Jordan Moran",
                    subTitle: "Bro, these are fire 🔥🔥",
                    timeFrame: "16:32"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
