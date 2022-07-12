import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:simple_link_preview/simple_link_preview.dart';
import 'package:whatsapp_application/constants/colors.dart';
import 'package:whatsapp_application/helper/size_config.dart';
import 'package:whatsapp_application/models/document.dart';
import 'package:whatsapp_application/views/call_page/calling_page.dart';
import 'package:whatsapp_application/views/profile_page/profile_page.dart';
import '../../helper/music_slider.dart';

Widget profileCircularWidget(BuildContext context, image) {
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
              color: !context.isDarkMode() ? Colors.white : Colors.black,
              border: Border.all(
                  width: 3,
                  color: !context.isDarkMode() ? Colors.white : Colors.black),
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

Widget circularTextField(
    {required TextEditingController controller,
    required String hintText,
    required ValueChanged<String> onChanged,
    ValueChanged<String>? onFieldSubmitted}) {
  return Container(
    height: !controller.text.contains("\n") ? null : 40,
    decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        border: Border.all(
            color: blackColor(SizeConfig.cntxt).lightShade.withOpacity(0.5))),
    child: Center(
      child: TextFormField(
        cursorColor: Colors.white,
        style: const TextStyle(color: Colors.white38),
        maxLines: 6,
        minLines: 1,
        controller: controller,
        onChanged: onChanged,
        onFieldSubmitted: onFieldSubmitted,
        decoration: InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            contentPadding:
                const EdgeInsets.only(left: 15, bottom: 8, top: 8, right: 15),
            hintText: hintText,
            hintStyle: TextStyle(
                color:
                    blackColor(SizeConfig.cntxt).darkShade.withOpacity(0.6))),
      ),
    ),
  );
}

Widget circularIconButton(
    {required IconData iconData,
    GestureTapCallback? onTap,
    ValueChanged<LongPressStartDetails>? onLongPressStart,
    ValueChanged<LongPressEndDetails>? onLongPressEnd}) {
  return GestureDetector(
    onTap: onTap,
    onLongPressStart: onLongPressStart,
    onLongPressEnd: onLongPressEnd,
    child: Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
              color: blackColor(SizeConfig.cntxt).lightShade.withOpacity(0.5))),
      child: Center(
        child: Icon(iconData,
            size: 25,
            color: blackColor(SizeConfig.cntxt).lightShade.withOpacity(0.5)),
      ),
    ),
  );
}

enum MessageType { text, audio, video, imageMedia, url, doc }

Widget circularMessage(
    {String? message,
    var imageMedia,
    String? audio,
    String? url,
    Document? file,
    required bool fromFriend,
    required MessageType messageType}) {
  switch (messageType) {
    case MessageType.text:
      return textMessage(message: message!, fromFriend: fromFriend);
    case MessageType.audio:
      return audioMessage(audio: audio!, fromFriend: fromFriend);
    case MessageType.video:
      return textMessage(message: message!, fromFriend: fromFriend);
    case MessageType.imageMedia:
      return gifMessage(gif: imageMedia!, fromFriend: fromFriend);
    case MessageType.url:
      return urlMessage(url: url!, fromFriend: fromFriend);
    case MessageType.doc:
      return docMessage(file: file!, fromFriend: fromFriend);
  }
}

Widget docMessage({required Document file, required bool fromFriend}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 20),
    child: Row(
      mainAxisAlignment:
          fromFriend ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        Container(
          width: SizeConfig.screenWidth * 0.8,
          height: 90,
          child: Column(
            children: [
              const SizedBox(height: 10,),
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(40)),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
                    child: Container(
                      width: (SizeConfig.screenWidth * 0.8) - 20,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200.withOpacity(0.5),
                          borderRadius: const BorderRadius.all(Radius.circular(40))),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 36,
                            height: 36,
                            child: Stack(
                              children: [
                                const Icon(Icons.insert_drive_file, size: 36,),
                                Center(child: Text(file.fileType.toUpperCase(), style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 9,
                                    color: grayColor(SizeConfig.cntxt).lightShade),
                                ),)
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(file.fileName.length>20?file.fileName.substring(0,8)+"..."+file.fileName.substring(file.fileName.length-9, file.fileName.length):file.fileName),
                          const Spacer(),
                          const Icon(LineIcons.download),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3.0),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text((file.bytesSize / 1024 / 1000).toStringAsFixed(2) + " MB", style: const TextStyle(
                          color: Colors.black87, fontSize: 12),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Spacer(),
                    const Text("7:31 PM", style: TextStyle(fontSize: 12),),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              )
            ],
          ),
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
        ),
      ],
    ),
  );
}

Widget urlMessage({required String url, required bool fromFriend}) {
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
              builder: (context, AsyncSnapshot<LinkPreview?> data) {
                if (data.hasData) {
                  return Column(
                    children: [
                      Container(
                        width: SizeConfig.screenWidth * 0.5,
                        height: SizeConfig.screenWidth * 0.25,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(data.data!.image!),
                                fit: BoxFit.cover),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          data.data!.title!,
                          style: TextStyle(
                              color: blackColor(context).darkShade,
                              fontSize: 12,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Text(data.data!.description!,
                            style: TextStyle(
                                color: blackColor(context).lightShade,
                                fontSize: 12),
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis),
                      )
                    ],
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
            decoration: BoxDecoration(
              border: Border.all(
                  color: blackColor(SizeConfig.cntxt)
                      .lightShade
                      .withOpacity(0.18)),
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

Widget audioMessage({required String audio, required bool fromFriend}) {
  return MusicSlider(
    emptyColor: greenColor,
    fillColor: blackColor(SizeConfig.cntxt).darkShade,
    height: 50,
    division: 53,
  );
}

Widget gifMessage({required var gif, required bool fromFriend}) {
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
                  fromFriend?DecorationImage(image: NetworkImage(gif), fit: BoxFit.cover):DecorationImage(image: MemoryImage(gif), fit: BoxFit.cover),
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
    child: InkWell(
      onTap: () {
        Navigator.of(context).push(CupertinoPageRoute(
            builder: (context) => ProfilePage(
                  user: user,
                  profilePageStatus: ProfilePageStatus.view,
                )));
      },
      child: SizedBox(
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
                              onTap: () {
                                Navigator.of(context).push(CupertinoPageRoute(
                                    builder: (context) => CallAcceptDeclinePage(
                                          user: user,
                                        )));
                              },
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
              padding: const EdgeInsets.only(top: 8.0),
              child: Divider(
                thickness: 0.3,
                height: 0,
                color: grayColor(context).darkShade.withOpacity(0.5),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
