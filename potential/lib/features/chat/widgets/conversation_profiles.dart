import 'package:flutter/material.dart';
import 'package:potential/features/chat/models/chat_message.dart';
import 'package:potential/features/chat/views/chat_list_item.dart';

class ConversationProfiles extends StatelessWidget {
  final List<ChatMessageModel> chatMessages;
  const ConversationProfiles({super.key, required this.chatMessages});

  @override
  Widget build(BuildContext context) {
    if (chatMessages.isEmpty) {
      return SizedBox.shrink();
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      
      itemCount: chatMessages.length,
      itemBuilder: (context, index) {
        final chatMessage = chatMessages[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 4.0),
          child: ChatListItem(chatMessage: chatMessage),
        );
      },
    );
  }
}
