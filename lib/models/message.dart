import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:whatsapp_redesign/constants/enums.dart';
import 'package:whatsapp_redesign/constants/extensions.dart';
import 'package:whatsapp_redesign/models/document.dart';
import 'package:whatsapp_redesign/models/upi_payment.dart';
import 'package:whatsapp_redesign/views/message_page/widgets/messages/audio_message.dart';
import 'package:whatsapp_redesign/views/message_page/widgets/messages/contact_message.dart';
import 'package:whatsapp_redesign/views/message_page/widgets/messages/documet_message.dart';
import 'package:whatsapp_redesign/views/message_page/widgets/messages/gif_message.dart';
import 'package:whatsapp_redesign/views/message_page/widgets/messages/location_message.dart';
import 'package:whatsapp_redesign/views/message_page/widgets/messages/payment_message.dart';
import 'package:whatsapp_redesign/views/message_page/widgets/messages/text_message.dart';
import 'package:whatsapp_redesign/views/message_page/widgets/messages/url_message.dart';

class Message {
  static const String dateTimeKey = 'dateTime';
  static const String messageKey = 'message';
  static const String gifUrlKey = 'gifUrl';
  static const String gifBytesKey = 'gifBytes';
  static const String audioKey = 'audio';
  static const String urlKey = 'url';
  static const String fileKey = 'file';
  static const String upiPaymentKey = 'upiPayment';
  static const String contactKey = 'contact';
  static const String latLngKey = 'latLng';
  static const String isIncomingMessageKey = 'isIncomingMessage';
  static const String messageTypeKey = 'messageType';

  final DateTime? dateTime;
  final String? message;
  final String? gifUrl;
  final Uint8List? gifBytes;
  final String? audio;
  final String? url;
  final Document? file;
  final UpiPayment? upiPayment;
  final Contact? contact;
  final LatLng? latLng;
  final bool isIncomingMessage;
  final MessageType messageType;

  DateTime get messageDateTime => dateTime ?? DateTime.now();

  Message(
      {this.dateTime,
      this.message,
      this.gifUrl,
      this.gifBytes,
      this.audio,
      this.url,
      this.file,
      this.upiPayment,
      this.contact,
      this.latLng,
      required this.isIncomingMessage,
      required this.messageType});

  factory Message.fromJson(Map<String, dynamic> data) => Message(
      dateTime: DateTime.parse(data[dateTimeKey]),
      message: data[messageKey],
      gifUrl: data[gifUrlKey],
      gifBytes: data[gifBytesKey],
      audio: data[audioKey],
      url: data[urlKey],
      file: data[fileKey] != null ? Document.fromJson(data[fileKey]): null,
      upiPayment: data[fileKey] != null ? UpiPayment.fromJson(data[upiPaymentKey]) : null,
      contact: data[fileKey] != null ? Contact.fromJson(data[contactKey]) : null,
      latLng: data[fileKey] != null ? LatLng.fromJson(data[latLngKey]) : null,
      isIncomingMessage: data[isIncomingMessageKey],
      messageType: data[messageTypeKey].toString().parse());

  Map<String, dynamic> toJson() => {
        dateTimeKey: dateTime?.toIso8601String(),
        messageKey: message,
        gifUrlKey: gifUrl,
        gifBytesKey: gifBytes,
        audioKey: audio,
        urlKey: url,
        fileKey: file?.toJson(),
        upiPaymentKey: upiPayment?.toJson(),
        contactKey: contact?.toJson(),
        latLngKey: latLng?.toJson(),
        isIncomingMessageKey: isIncomingMessage,
        messageTypeKey: messageType.format(),
      };

  Widget render(chatId) {
    switch (messageType) {
      case MessageType.text:
        return TextMessage(
            message: message!, isIncomingMessage: isIncomingMessage);
      case MessageType.audio:
        return AudioMessage(isIncomingMessage: isIncomingMessage);
      case MessageType.video:
        return const SizedBox();
      case MessageType.imageMedia:
        return GifMessage(
          gifUrl: gifUrl,
          isIncomingMessage: isIncomingMessage,
          gifBytes: gifBytes,
        );
      case MessageType.url:
        return UrlMessage(url: url!, isIncomingMessage: isIncomingMessage);
      case MessageType.doc:
        return DocumentMessage(
            file: file!, isIncomingMessage: isIncomingMessage);
      case MessageType.upiPayment:
        return PaymentMessage(
            payment: upiPayment!, isIncomingMessage: isIncomingMessage);
      case MessageType.contact:
        return ContactMessage(
            contact: contact!, isIncomingMessage: isIncomingMessage, chatId: chatId,);
      case MessageType.location:
        return LocationMessage(
            latLng: latLng!, isIncomingMessage: isIncomingMessage);
      default:
        return const SizedBox();
    }
  }
}
