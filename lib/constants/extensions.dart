import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

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
