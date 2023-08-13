import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_redesign/constants/colors.dart';
import 'package:whatsapp_redesign/constants/enums.dart';
import 'package:whatsapp_redesign/constants/extensions.dart';
import 'package:whatsapp_redesign/constants/persons.dart';
import 'package:whatsapp_redesign/managers/firestore_manager.dart';
import 'package:whatsapp_redesign/managers/local_db_manager/local_db.dart';
import 'package:whatsapp_redesign/models/chat.dart';
import 'package:whatsapp_redesign/provider/home_provider.dart';
import 'package:whatsapp_redesign/views/contact_page/contact_page.dart';
import 'package:whatsapp_redesign/views/home_page/widgets/search_bar.dart';
import 'package:whatsapp_redesign/views/home_page/widgets/status_bar.dart';
import 'package:whatsapp_redesign/views/message_page/message_page.dart';
import 'package:whatsapp_redesign/widgets/custom_listtile.dart';
import 'package:whatsapp_redesign/widgets/custom_loader.dart';
import 'package:whatsapp_redesign/widgets/gradient_icon_button.dart';
import 'package:whatsapp_redesign/widgets/no_data_found.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, this.scrollController}) : super(key: key);

  final ScrollController? scrollController;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeProvider? provider;

  @override
  void initState() {
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   provider = Provider.of<HomeProvider>(context, listen: false);
    //   provider!.fetchChats();
    //   provider!.fetchStatusList();
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor(context),
      floatingActionButton: Consumer<HomeProvider>(
        builder: (context, provider, child) => !provider.isSearch
            ? FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).push(CupertinoPageRoute(
                      builder: (context) => const ContactPage()));
                },
                backgroundColor: Colors.transparent,
                child: const GradientIconButton(
                    size: 55, iconData: Icons.group_add),
              )
            : const SizedBox(),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Consumer<HomeProvider>(builder: (context, provider, child) {
            return Column(
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
                        provider.isSearch ? "Search" : "Chats",
                        style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w800,
                            color: blackColor(context).darkShade),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: IconButton(
                        icon: Icon(
                            provider.isSearch ? Icons.close : Icons.search,
                            size: 32),
                        splashRadius: 20,
                        onPressed: () {
                          provider.toggleIsSearch();
                          provider.controller.clear();
                        },
                        color: greenColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                provider.isSearch
                    ? SearchBarWidget(controller: provider.controller)
                    : StatusBar(
                        statusList: provider.statusList,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "Are you sure to logout ?",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color:
                                                blackColor(context).darkShade,
                                            fontSize: 19),
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      ButtonBar(
                                        buttonPadding: EdgeInsets.zero,
                                        alignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          ElevatedButton(
                                            style: ButtonStyle(
                                                fixedSize:
                                                    MaterialStateProperty.all(
                                                        const Size(150, 30)),
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        greenColor)),
                                            onPressed: () {},
                                            child: const Text(
                                              'Yes, log out!',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          ElevatedButton(
                                            style: ButtonStyle(
                                                fixedSize:
                                                    MaterialStateProperty.all(
                                                        const Size(100, 30)),
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        backgroundColor(
                                                            context)),
                                                side: MaterialStateProperty.all(
                                                    const BorderSide(
                                                        color: greenColor))),
                                            onPressed: () {},
                                            child: const Text('Cancel',
                                                style: TextStyle(
                                                    color: greenColor)),
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
            );
          }),
          Consumer<HomeProvider>(
            builder: (context, provider, child) => Expanded(
              child: provider.isSearch &&
                      provider.controller.text.trim().isNotEmpty
                  ? const Center(
                      child: CustomLoader(),
                    )
                  : StreamBuilder(
                      stream: provider.manager.getUserChats(LocalDB.user.uuid),
                      builder: (context, data) {
                        if (data.connectionState == ConnectionState.done &&
                            data.data != null) {
                          List<Chat> chats = data.data!.docs
                              .map((e) => Chat.fromJson(e.data()))
                              .toList();
                          return ListView.separated(
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
                                extentRatio:
                                    provider.SLIDABLE_WIDGET_WIDTH_RATIO,
                                dismissible: DismissiblePane(onDismissed: () {
                                  // provider.removeChatAtIndex(index);
                                }),
                                children: [
                                  CustomSlidableAction(
                                    backgroundColor: greenColor,
                                    onPressed: (BuildContext context) {},
                                    child: Center(
                                      child: Icon(LineIcons.userSecret,
                                          color: Colors.white,
                                          size: provider.SLIDABLE_ICON_SIZE),
                                    ),
                                  )
                                ],
                              ),
                              endActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                extentRatio:
                                    (provider.SLIDABLE_WIDGET_WIDTH_RATIO) * 2,
                                dismissible:
                                    DismissiblePane(onDismissed: () {}),
                                children: [
                                  CustomSlidableAction(
                                    onPressed: (_) {},
                                    backgroundColor:
                                        grayColor(context).lightShade,
                                    foregroundColor: Colors.white,
                                    child: Icon(
                                      Icons.more_horiz_outlined,
                                      size: provider.SLIDABLE_ICON_SIZE,
                                    ),
                                  ),
                                  CustomSlidableAction(
                                    onPressed: (_) {},
                                    backgroundColor: const Color(0xFFE25C5C),
                                    foregroundColor: Colors.white,
                                    child: Icon(Icons.delete_outline,
                                        size: provider.SLIDABLE_ICON_SIZE),
                                  ),
                                ],
                              ),
                              child: CustomListTile(
                                  isOnline: index == 3 ? false : true,
                                  imageUrl: chats[index].user.picture,
                                  title: chats[index].user.name,
                                  subTitle: sentences[index],
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(CupertinoPageRoute(
                                            builder: (context) => MessagePage(
                                                  user: chats[index].user,
                                                )));
                                  },
                                  customListTileType:
                                      chats[index].fromChatType(),
                                  participants: chats,
                                  timeFrame: chats[index]
                                      .lastMessage
                                      .dateTime
                                      .formatToHHMM()),
                            ),
                          );
                        } else if (data.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(child: CustomLoader());
                        } else {
                          return const Center(child: NoDataFound());
                        }
                      },
                    ),
            ),
          )
        ],
      )),
    );
  }
}
