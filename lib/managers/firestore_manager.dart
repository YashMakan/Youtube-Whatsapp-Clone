import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatsapp_redesign/constants/enums.dart';
import 'package:whatsapp_redesign/managers/local_db_manager/local_db.dart';
import 'package:whatsapp_redesign/models/chat.dart';
import 'package:whatsapp_redesign/models/message.dart';
import 'package:whatsapp_redesign/models/user.dart';

class Collections {
  static const String chats = 'chats';
  static const String users = 'users';
  static const String messages = 'messages';
}

class ChatAndUser {
  final Chat? chat;
  final User? user;

  ChatAndUser({this.chat, this.user});
}

class FirestoreManager {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> isUserExist({String? phoneNumber, String? uuid}) async {
    if (phoneNumber == null && uuid == null) {
      throw Exception('phoneNumber and uuid both can\'t be null');
    }
    final userSnapshot;
    if (phoneNumber != null) {
      userSnapshot = await _firestore
          .collection(Collections.users)
          .where(User.phoneNumberKey, isEqualTo: phoneNumber)
          .get();
    } else {
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

  Future<ChatAndUser> getChat(String phone) async {
    User? user;
    Chat? chat;

    final userSnapshot = await _firestore
        .collection(Collections.users)
        .where(User.phoneNumberKey, isEqualTo: phone)
        .get();

    if (userSnapshot.docs.isNotEmpty) {
      final userDocRef = userSnapshot.docs.first.reference;
      user = User.fromJson(userSnapshot.docs.first.data());
      try {
        final chatData = (await userDocRef
                .collection(Collections.chats)
                .where('uuid', isEqualTo: LocalDB.user.uuid)
                .get())
            .docs
            .first;
        if (chatData.exists) {
          chat = Chat.fromJson(chatData.data());
        }
      } catch (_) {}
    }
    return ChatAndUser(chat: chat, user: user);
  }

  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> getUserChats(
      String userId) async {
    final userSnapshot = (await _firestore
        .collection(Collections.users)
        .where('uuid', isEqualTo: LocalDB.user.uuid)
        .get());
    final chatsSnapshot = _firestore
        .collection(Collections.users)
        .doc(userSnapshot.docs.first.id)
        .collection(Collections.chats)
        .snapshots();
    return chatsSnapshot;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getChatMessages(String chatId) {
    final messagesSnapshot = _firestore
        .collection(Collections.chats)
        .doc(chatId)
        .collection(Collections.messages)
        .orderBy(Message.dateTimeKey)
        .snapshots();
    return messagesSnapshot;
  }

  Future<void> sendChatMessage(
      String chatId, Message message, User user) async {
    _firestore
        .collection(Collections.chats)
        .doc(chatId)
        .collection(Collections.messages)
        .add(message.toJson());

    final userSnapshot = await _firestore
        .collection(Collections.users)
        .where(User.uuidKey, isEqualTo: LocalDB.user.uuid)
        .get();
    final userDocRef = userSnapshot.docs.first.reference;
    bool exists1 =
        (await userDocRef.collection(Collections.chats).doc(chatId).get())
            .exists;
    if (exists1) {
      await userDocRef.collection(Collections.chats).doc(chatId).update(Chat(
              user,
              ChatType.message,
              message,
              0,
              DateTime.now(),
              chatId,
              user.uuid)
          .toJson());
    } else {
      await userDocRef.collection(Collections.chats).doc(chatId).set(Chat(user,
              ChatType.message, message, 0, DateTime.now(), chatId, user.uuid)
          .toJson());
    }

    final userSnapshot2 = await _firestore
        .collection(Collections.users)
        .where(User.uuidKey, isEqualTo: user.uuid)
        .get();
    final userDocRef2 = userSnapshot2.docs.first.reference;
    bool exists2 =
        (await userDocRef2.collection(Collections.chats).doc(chatId).get())
            .exists;
    if (exists2) {
      await userDocRef2.collection(Collections.chats).doc(chatId).update(Chat(
              LocalDB.user,
              ChatType.message,
              message,
              0,
              DateTime.now(),
              chatId,
              LocalDB.user.uuid)
          .toJson());
    } else {
      await userDocRef2.collection(Collections.chats).doc(chatId).set(Chat(
              LocalDB.user,
              ChatType.message,
              message,
              0,
              DateTime.now(),
              chatId,
              LocalDB.user.uuid)
          .toJson());
    }
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
