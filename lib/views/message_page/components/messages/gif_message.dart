import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:whatsapp_application/helper/size_config.dart';

class GifMessage extends StatefulWidget {
  final String? gifUrl;
  final bool fromFriend;
  final Uint8List? gifBytes;

  const GifMessage(
      {Key? key, this.gifUrl, required this.fromFriend, this.gifBytes})
      : super(key: key);

  @override
  State<GifMessage> createState() => _GifMessageState();
}

class _GifMessageState extends State<GifMessage> {
  late bool fromFriend;
  late String? gifUrl;
  late Uint8List? gifBytes;

  @override
  void initState() {
    fromFriend = widget.fromFriend;
    gifUrl = widget.gifUrl;
    gifBytes = widget.gifBytes;
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
              width: SizeConfig.screenWidth * 0.45,
              height: SizeConfig.screenWidth * 0.5,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white24.withOpacity(0.18)),
                image: fromFriend || gifUrl!=null
                    ? DecorationImage(
                        image: NetworkImage(gifUrl!), fit: BoxFit.cover)
                    : DecorationImage(
                        image: MemoryImage(gifBytes!), fit: BoxFit.cover),
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
}
