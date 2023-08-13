import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatsapp_redesign/models/user.dart';

class Collections {
  static const String chats = 'chats';
  static const String users = 'users';
}

class FirestoreManager {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> isUserExist({String? phoneNumber, String? uuid}) async {
    print((await _firestore.collection(Collections.users).get())
        .docs
        .first
        .data());
    if(phoneNumber == null && uuid == null) {
      throw Exception('phoneNumber and uuid both can\'t be null');
    }
    final userSnapshot;
    if(phoneNumber != null) {
      userSnapshot = await _firestore
          .collection(Collections.users)
          .where(User.phoneNumberKey, isEqualTo: phoneNumber)
          .get();
    }else {
      userSnapshot = await _firestore
          .collection(Collections.users)
          .where(User.uuidKey, isEqualTo: uuid)
          .get();
    }
    return userSnapshot.docs.isNotEmpty;
  }

  Future<void> registerUser(User user) async {
    await _firestore.collection(Collections.users).add(user.toJson());
  }

  Future<User> getUser(phoneNumber) async {
    final userSnapshot = await _firestore
        .collection(Collections.users)
        .where(User.phoneNumberKey, isEqualTo: phoneNumber)
        .get();
    return User.fromJson(userSnapshot.docs.first.data());
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getUserChats(String userId) {
    final chatsSnapshot = _firestore
        .collection(Collections.users)
        .doc(userId)
        .collection(Collections.chats)
        .snapshots();
    return chatsSnapshot;
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getChatMessages(
      String chatId) async {
    final messagesSnapshot = await _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp')
        .get();
    return messagesSnapshot;
  }

  Future<void> sendChatMessage(
      String chatId, Map<String, dynamic> newMessageData) async {
    await _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .add(newMessageData);
  }
}

// static sendNotificationRequestToFriendToAcceptCall(
//     String roomId, User user) async {
//   var data = jsonEncode({
//     "uuid": user.uuid,
//     "caller_id": user.phoneNumber,
//     "caller_name": user.name,
//     "caller_id_type": "number",
//     "has_video": "false",
//     "room_id": roomId,
//     "fcm_token": user.firebaseToken
//   });
//   var r = await http.post(Uri.parse("$apiUrl/send-notification"),
//       body: data, headers: {"Content-Type": "application/json"});
//   print(r.body);
// }
