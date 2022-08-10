import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:whatsapp_application/constants/colors.dart';
import 'package:whatsapp_application/helper/size_config.dart';
import 'package:whatsapp_application/models/document.dart';

class DocumentMessage extends StatefulWidget {
  final Document file;
  final bool fromFriend;
  const DocumentMessage({Key? key, required this.file, required this.fromFriend}) : super(key: key);

  @override
  State<DocumentMessage> createState() => _DocumentMessageState();
}

class _DocumentMessageState extends State<DocumentMessage> {
  late Document file;
  late bool fromFriend;
  @override
  void initState() {
    file = widget.file;
    fromFriend = widget.fromFriend;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
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
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(40)),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
                      child: Container(
                        width: (SizeConfig.screenWidth * 0.8) - 20,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200.withOpacity(0.5),
                            borderRadius:
                            const BorderRadius.all(Radius.circular(40))),
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
                                  Icon(
                                    Icons.insert_drive_file,
                                    size: 36,
                                    color: fromFriend?Colors.white70:Colors.black87,
                                  ),
                                  Center(
                                    child: Text(
                                      file.fileType.toUpperCase(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 9,
                                          color: fromFriend?Colors.black54:grayColor(SizeConfig.cntxt)
                                              .lightShade),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(file.fileName.length > 20
                                ? file.fileName.substring(0, 8) +
                                "..." +
                                file.fileName.substring(
                                    file.fileName.length - 9,
                                    file.fileName.length)
                                : file.fileName, style: TextStyle(color: fromFriend?Colors.white:Colors.black),),
                            const Spacer(),
                            Icon(LineIcons.download, color: fromFriend?Colors.white70:Colors.black87,),
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
                      SizedBox(
                        width: fromFriend?0:10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text(
                          (file.bytesSize / 1024 / 1000).toStringAsFixed(2) +
                              " MB",
                          style: TextStyle(
                              color: fromFriend?Colors.white70:Colors.black87, fontSize: 12),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Spacer(),
                      Text(
                        "7:31 PM",
                        style: TextStyle(fontSize: 12, color: fromFriend?Colors.white70:Colors.black87),
                      ),
                      SizedBox(
                        width: fromFriend?30:10,
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
}
