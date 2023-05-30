import 'dart:typed_data';
import 'package:latlong2/latlong.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:whatsapp_application/constants/enums.dart';
import 'package:whatsapp_application/models/document.dart';
import 'package:whatsapp_application/models/upi_payment.dart';
import 'package:whatsapp_application/views/message_page/widgets/messages/audio_message.dart';
import 'package:whatsapp_application/views/message_page/widgets/messages/contact_message.dart';
import 'package:whatsapp_application/views/message_page/widgets/messages/documet_message.dart';
import 'package:whatsapp_application/views/message_page/widgets/messages/gif_message.dart';
import 'package:whatsapp_application/views/message_page/widgets/messages/location_message.dart';
import 'package:whatsapp_application/views/message_page/widgets/messages/payment_message.dart';
import 'package:whatsapp_application/views/message_page/widgets/messages/text_message.dart';
import 'package:whatsapp_application/views/message_page/widgets/messages/url_message.dart';

class CircularMessage extends StatelessWidget {
  final String? message;
  final String? gifUrl;
  final Uint8List? gifBytes;
  final String? audio;
  final String? url;
  final Document? file;
  final UpiPayment? upiPayment;
  final Contact? contact;
  final LatLng? latLng;
  final bool fromFriend;
  final MessageType messageType;

  const CircularMessage({
    Key? key,
    this.message,
    this.gifUrl,
    this.gifBytes,
    this.audio,
    this.url,
    this.file,
    this.upiPayment,
    this.contact,
    this.latLng,
    required this.fromFriend,
    required this.messageType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      default:
        return const SizedBox();
    }
  }
}
