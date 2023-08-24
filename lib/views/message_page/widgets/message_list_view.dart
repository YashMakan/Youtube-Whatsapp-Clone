import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:whatsapp_redesign/models/message.dart';
import 'package:whatsapp_redesign/provider/message_provider.dart';

class MessageListScreen extends StatefulWidget {
  const MessageListScreen({super.key});

  @override
  State<MessageListScreen> createState() => _MessageListScreenState();
}

class _MessageListScreenState extends State<MessageListScreen> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Consumer<MessageProvider>(builder: (context, provider, child) {
        if (provider.chatId == null) {
          return const SizedBox();
        }
        return StreamBuilder(
            stream: provider.manager.getChatMessages(provider.chatId!),
            builder: (context, data) {
              final docs = data.data?.docs;
              if (docs == null) {
                return const SizedBox();
              } else {
                List<Message> messages =
                    docs.map((e) => Message.fromJson(e.data())).toList();
                Future.delayed(const Duration(milliseconds: 200), () {
                  scrollToBottom(provider, messages.length);
                });
                return ScrollablePositionedList.builder(
                  itemScrollController: provider.scrollController,
                  itemCount: messages.length,
                  itemBuilder: (context, index) => messages[index]
                      .render(provider.chatId, provider.user?.uuid),
                );
              }
            });
      }),
    ));
  }

  scrollToBottom(MessageProvider provider, int messagesLength,
      {bool jump = false}) {
    if (jump) {
      provider.scrollController.jumpTo(index: messagesLength);
    } else {
      provider.scrollController.scrollTo(
          index: messagesLength, duration: const Duration(milliseconds: 600));
    }
  }
}
