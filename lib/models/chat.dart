import 'package:whatsapp_redesign/constants/enums.dart';
import 'package:whatsapp_redesign/models/user.dart';

import 'message.dart';

class Chat {
  final User user;
  final ChatType chatType;
  final Message lastMessage;
  final int unreadMessages;

  Chat(this.user, this.chatType, this.lastMessage, this.unreadMessages);

  CustomListTileType fromChatType() {
    switch (chatType) {
      case ChatType.message:
        return CustomListTileType.message;
      case ChatType.group:
        return CustomListTileType.group;
    }
  }

  factory Chat.fromJson(Map<String, dynamic> data) => Chat(
      User.fromJson(data['user']),
      data['chatType'] == 'message' ? ChatType.message : ChatType.group,
      Message.fromJson(data['lastMessage']),
      data['unreadMessages']);
}
