import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:latlong2/latlong.dart';
import 'package:whatsapp_application/constants/colors.dart';
import 'package:whatsapp_application/helper/size_config.dart';
import 'package:whatsapp_application/models/document.dart';
import 'package:whatsapp_application/models/upi_payment.dart';
import 'package:whatsapp_application/views/message_page/components/messages/audio_message.dart';
import 'package:whatsapp_application/views/message_page/components/messages/documet_message.dart';
import 'package:whatsapp_application/views/message_page/components/messages/gif_message.dart';
import 'package:whatsapp_application/views/message_page/components/messages/location_message.dart';
import 'package:whatsapp_application/views/message_page/components/messages/text_message.dart';
import 'package:whatsapp_application/views/message_page/components/messages/url_message.dart';

import 'components/messages/contact_message.dart';
import 'components/messages/payment_message.dart';

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

enum MessageType {
  text,
  audio,
  video,
  imageMedia,
  url,
  doc,
  upiPayment,
  contact,
  location
}

Widget circularMessage(
    {String? message,
    String? gifUrl,
    Uint8List? gifBytes,
    String? audio,
    String? url,
    Document? file,
    UpiPayment? upiPayment,
    Contact? contact,
    LatLng? latLng,
    required bool fromFriend,
    required MessageType messageType}) {
  switch (messageType) {
    case MessageType.text:
      return TextMessage(message: message!, fromFriend: fromFriend);
    case MessageType.audio:
      return AudioMessage(fromFriend: fromFriend);
    case MessageType.video:
      return const SizedBox();
    case MessageType.imageMedia:
      return GifMessage(
        gifUrl: gifUrl,
        fromFriend: fromFriend,
        gifBytes: gifBytes,
      );
    case MessageType.url:
      return UrlMessage(url: url!, fromFriend: fromFriend);
    case MessageType.doc:
      return DocumentMessage(file: file!, fromFriend: fromFriend);
    case MessageType.upiPayment:
      return PaymentMessage(payment: upiPayment!, fromFriend: fromFriend);
    case MessageType.contact:
      return ContactMessage(contact: contact!, fromFriend: fromFriend);
    case MessageType.location:
      return LocationMessage(latLng: latLng!, fromFriend: fromFriend);
  }
}
