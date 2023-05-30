import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserProfile(
      String userId) async {
    final userSnapshot = await _firestore.collection('users').doc(userId).get();
    return userSnapshot;
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getUserChats(
      String userId) async {
    final chatsSnapshot = await _firestore
        .collection('chats')
        .where('participants', arrayContains: userId)
        .get();
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