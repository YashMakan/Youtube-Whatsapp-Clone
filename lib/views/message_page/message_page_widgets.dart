import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:simple_link_preview/simple_link_preview.dart';
import 'package:whatsapp_application/constants/colors.dart';
import 'package:whatsapp_application/helper/size_config.dart';
import '../../helper/music_slider.dart';

Widget profileCircularWidget(context, image) {
  return Stack(
    clipBehavior: Clip.none,
    children: [
      Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(image: NetworkImage(image))),
      ),
      Positioned(
        bottom: -5,
        right: -5,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.black,
              border: Border.all(width: 3, color: backgroundColor(context)),
              shape: BoxShape.circle),
          child: const Padding(
            padding: EdgeInsets.all(2.0),
            child: Icon(Icons.circle, size: 14, color: greenColor),
          ),
        ),
      )
    ],
  );
}

Widget circularTextField() {
  return Container(
    height: 40,
    padding: const EdgeInsets.only(bottom: 8),
    decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(40)),
        border: Border.all(color: Colors.white24)),
    child: TextFormField(
      cursorColor: Colors.white,
      style: const TextStyle(color: Colors.white38),
      maxLines: 10,
      minLines: 1,
      decoration: const InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          contentPadding:
              EdgeInsets.only(left: 15, bottom: 8, top: 8, right: 15),
          hintText: "Respond...",
          hintStyle: TextStyle(color: Colors.white70)),
    ),
  );
}

Widget circularIconButton(iconData, onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
          shape: BoxShape.circle, border: Border.all(color: Colors.white24)),
      child: Center(
        child: Icon(iconData, size: 25, color: Colors.white70),
      ),
    ),
  );
}

enum MessageType { text, audio, video, gif, url }

Widget circularMessage(
    {String? message,
    String? gif,
    String? audio,
      String? url,
    required bool fromFriend,
    required MessageType messageType}) {
  switch (messageType) {
    case MessageType.text:
      return textMessage(message: message!, fromFriend: fromFriend);
    case MessageType.audio:
      return audioMessage(
          audio: audio!,
          fromFriend: fromFriend);
    case MessageType.video:
      return textMessage(message: message!, fromFriend: fromFriend);
    case MessageType.gif:
      return gifMessage(gif: gif!, fromFriend: fromFriend);
    case MessageType.url:
      return urlMessage(url: url!, fromFriend: fromFriend);
  }
}

Widget urlMessage({required String url, required bool fromFriend}){
  return Padding(
    padding: const EdgeInsets.only(bottom: 20),
    child: Row(
      mainAxisAlignment:
      fromFriend ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        Container(
            width: SizeConfig.screenWidth * 0.5,
            height: SizeConfig.screenWidth * 0.6,
            child: FutureBuilder(
              future: SimpleLinkPreview.getPreview(url),
              builder: (context, AsyncSnapshot<LinkPreview?> data){
                if(data.hasData){
                  return Column(
                    children: [
                      Container(
                        width: SizeConfig.screenWidth * 0.5,
                        height: SizeConfig.screenWidth * 0.25,
                        decoration: BoxDecoration(
                          image: DecorationImage(image: NetworkImage(data.data!.image!), fit: BoxFit.cover),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          )
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(data.data!.title!, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Text(data.data!.description!, style: const TextStyle(color: Colors.white38, fontSize: 12), maxLines: 4, overflow: TextOverflow.ellipsis),
                      )
                    ],
                  );
                }else{
                  return const SizedBox();
                }
              },
            ),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white24.withOpacity(0.18)),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(fromFriend ? 0 : 40),
                  topLeft: const Radius.circular(40),
                  topRight: const Radius.circular(40),
                  bottomRight: Radius.circular(fromFriend ? 40 : 0)),
            )),
      ],
    ),
  );
}

Widget audioMessage(
    {required String audio,
    required bool fromFriend}) {
  return MusicSlider(
    emptyColor: greenColor,
    fillColor: blackColor(SizeConfig.cntxt).darkShade,
    height: 50,
    division: 53,
  );
}

Widget gifMessage({required String gif, required bool fromFriend}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 20),
    child: Row(
      mainAxisAlignment:
          fromFriend ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        Container(
            width: SizeConfig.screenWidth * 0.45,
            height: SizeConfig.screenWidth * 0.5,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white24.withOpacity(0.18)),
              image:
                  DecorationImage(image: NetworkImage(gif), fit: BoxFit.cover),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(fromFriend ? 0 : 40),
                  topLeft: const Radius.circular(40),
                  topRight: const Radius.circular(40),
                  bottomRight: Radius.circular(fromFriend ? 40 : 0)),
            )),
      ],
    ),
  );
}

Widget textMessage({required String message, required bool fromFriend}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 20),
    child: Row(
      mainAxisAlignment:
          fromFriend ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        Container(
            constraints: BoxConstraints(maxWidth: SizeConfig.screenWidth * 0.8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(fromFriend ? 0 : 40),
                  topLeft: const Radius.circular(40),
                  topRight: const Radius.circular(40),
                  bottomRight: Radius.circular(fromFriend ? 40 : 0)),
              color: fromFriend ? const Color(0xFF313131) : null,
              gradient: fromFriend
                  ? null
                  : LinearGradient(colors: [
                      greenGradient.lightShade,
                      greenGradient.darkShade,
                    ]),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16),
              child: Text(
                message,
                style: const TextStyle(color: Colors.white),
              ),
            )),
      ],
    ),
  );
}

Widget headerSection(context, user) {
  return SafeArea(
    child: Column(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 26,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  profileCircularWidget(context, user.picture),
                  const SizedBox(
                    width: 16,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.name,
                        style: TextStyle(
                            color: blackColor(context).darkShade,
                            fontSize: 18,
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        "Online",
                        style: TextStyle(
                            color: blackColor(context).lightShade,
                            fontSize: 13),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      GestureDetector(
                          onTap: () {},
                          child: const Icon(
                            LineIcons.phone,
                            size: 27,
                            color: greenColor,
                          )),
                      const SizedBox(
                        width: 16,
                      ),
                      GestureDetector(
                          onTap: () {},
                          child: const Icon(
                            LineIcons.video,
                            size: 27,
                            color: greenColor,
                          ))
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Divider(
            thickness: 0.3,
            color: grayColor(context).darkShade.withOpacity(0.3),
          ),
        ),
      ],
    ),
  );
}
