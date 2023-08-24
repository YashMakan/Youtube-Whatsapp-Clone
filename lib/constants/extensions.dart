import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:whatsapp_redesign/constants/enums.dart';

extension Utils on BuildContext {
  String getUUid() {
    var uuid = const Uuid();
    return uuid.v1();
  }

  Future<String?> getFCMToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    return token;
  }
}

extension CustomDateTime on DateTime {
  String formatToHHMM() {
    return DateFormat("HH:mm").format(this);
  }
}

extension MessageTypeExtension on MessageType {
  String format() {
    return name;
  }
}

extension MessageTypeParser on String {
  MessageType parse() {
    switch(this) {
      case "text":
        return MessageType.text;
      case "audio":
        return MessageType.audio;
      case "video":
        return MessageType.video;
      case "imageMedia":
        return MessageType.imageMedia;
      case "url":
        return MessageType.url;
      case "doc":
        return MessageType.doc;
      case "upiPayment":
        return MessageType.upiPayment;
      case "contact":
        return MessageType.contact;
      case "location":
        return MessageType.location;
      default:
        return MessageType.text;
    }
  }
}