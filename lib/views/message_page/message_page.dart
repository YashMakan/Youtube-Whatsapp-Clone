import 'package:flutter/material.dart';
import 'package:giphy_api_client/giphy_api_client.dart';
import 'package:line_icons/line_icons.dart';
import 'package:whatsapp_application/models/user.dart';
import 'package:whatsapp_application/views/message_page/message_page_widgets.dart';
import '../../constants/colors.dart';
import '../../helper/size_config.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  bool isSearch = false;
  bool isGifClicked = false;
  TextEditingController messageController = TextEditingController();
  TextEditingController gifController = TextEditingController();
  final client = GiphyClient(apiKey: 'NMFj5k2Slp67Tg2lSUANshwMFS9qTiB1');
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor(context),
      body: Column(
        children: [
          headerSection(context, widget.user),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: ListView(
              controller: scrollController,
              padding: const EdgeInsets.only(top: 20),
              children: [
                circularMessage(
                    fromFriend: true,
                    messageType: MessageType.text,
                    message: "Whatcha doing bro? 🤔"),
                circularMessage(
                    fromFriend: false,
                    messageType: MessageType.text,
                    message:
                        "nah! bro, nothing much but I found a great channel on YouTube"),
                circularMessage(
                    fromFriend: true,
                    messageType: MessageType.gif,
                    gif: "https://i.giphy.com/media/oOTTyHRHj0HYY/giphy.webp"),
                circularMessage(
                    fromFriend: false,
                    messageType: MessageType.url,
                    url: "https://www.youtube.com/watch?v=yqsb3gKP_N4"),
                circularMessage(
                    fromFriend: false,
                    messageType: MessageType.text,
                    message:
                        "Yeah! You can watch this video where he is explaining about a whatsapp clone!"),
                circularMessage(
                    fromFriend: true,
                    messageType: MessageType.text,
                    message: "Wowww! That does sound cool"),
                circularMessage(
                    fromFriend: true,
                    messageType: MessageType.text,
                    message:
                        "I am going to subscribe the channel right NOW!!!"),
              ],
            ),
          )),
          isGifClicked
              ? SizedBox(
                  width: SizeConfig.screenWidth,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 16.0),
                    child: Row(
                      children: [
                        circularIconButton(Icons.gif, () {
                          setState(() {
                            isGifClicked = !isGifClicked;
                          });
                        }),
                        const SizedBox(
                          width: 8.0,
                        ),
                        Expanded(
                            child: circularTextField(
                                controller: gifController,
                                hintText: "Search...")),
                        const SizedBox(
                          width: 8.0,
                        ),
                        circularIconButton(LineIcons.search, () {
                          setState(() {
                            FocusManager.instance.primaryFocus?.unfocus();
                          });
                        }),
                      ],
                    ),
                  ),
                )
              : SizedBox(
                  width: SizeConfig.screenWidth,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 16.0),
                    child: Row(
                      children: [
                        circularIconButton(Icons.gif, () {
                          setState(() {
                            isGifClicked = !isGifClicked;
                          });
                        }),
                        const SizedBox(
                          width: 8.0,
                        ),
                        Expanded(
                            child: circularTextField(
                                controller: messageController,
                                hintText: "Respond...")),
                        const SizedBox(
                          width: 8.0,
                        ),
                        circularIconButton(LineIcons.microphone, () {}),
                        const SizedBox(
                          width: 8.0,
                        ),
                        circularIconButton(LineIcons.horizontalEllipsis, () {})
                      ],
                    ),
                  ),
                ),
          isGifClicked
              ? SizedBox(
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight * 0.2,
                  child: Column(
                    children: [
                      FutureBuilder(
                        future: gifController.text.isEmpty
                            ? client.trending()
                            : client.search(gifController.text),
                        builder:
                            (context, AsyncSnapshot<GiphyCollection> snapshot) {
                          List<GiphyGif?> gifs = snapshot.data?.data ?? [];
                          if (snapshot.hasData) {
                            return Expanded(
                              child: GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 15.0,
                                          mainAxisSpacing: 15.0,
                                          childAspectRatio: 1.4),
                                  padding: EdgeInsets.zero,
                                  itemCount: gifs.length,
                                  itemBuilder: (context, index) {
                                    return Image.network(
                                      gifs[index]?.images?.original?.url ?? "",
                                      width: 50,
                                      height: 30,
                                      fit: BoxFit.cover,
                                    );
                                  }),
                            );
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        },
                      )
                    ],
                  ))
              : const SizedBox(),
        ],
      ),
    );
  }
}
