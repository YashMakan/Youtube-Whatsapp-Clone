import 'package:flutter/material.dart';
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
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor(context),
      body: Column(
        children: [
          headerSection(context, widget.user),
          const SizedBox(
            height: 8,
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView(
              padding: EdgeInsets.zero,
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
          SizedBox(
            width: SizeConfig.screenWidth,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Row(
                children: [
                  circularIconButton(Icons.gif, () {}),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Expanded(child: circularTextField()),
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
          )
        ],
      ),
    );
  }
}
