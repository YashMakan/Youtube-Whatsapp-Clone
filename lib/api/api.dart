import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:whatsapp_application/models/user.dart';

class Api {
  static const String apiUrl = "API_URL/LOCALHOST";

  static sendNotificationRequestToFriendToAcceptCall(String roomId, User user) async {
    var data = jsonEncode({
      "uuid": user.uuid,
      "caller_id": user.phoneNumber,
      "caller_name": user.name,
      "caller_id_type": "number",
      "has_video": "false",
      "room_id": roomId,
      "fcm_token": user.firebaseToken
    });
    var r = await http.post(Uri.parse("$apiUrl/send-notification"), body: data, headers: {"Content-Type": "application/json"});
    print(r.body);
  }
}