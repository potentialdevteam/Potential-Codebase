import 'package:flutter/material.dart';
import 'package:potential/core/constants/colors.dart';
import 'package:potential/features/chat/models/chat_message.dart';

class ChatListItem extends StatelessWidget {
  final ChatMessageModel chatMessage;
  const ChatListItem({super.key, required this.chatMessage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 28,
            backgroundImage: NetworkImage(
              chatMessage.participateProfile.profilePictureUrl,
            ),
            backgroundColor: AppColors.accentWhite,
          ),
          SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  chatMessage.participateProfile.name,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Text(
                  chatMessage.lastMessage,
                  style: TextStyle(color: Colors.grey[350], fontSize: 14),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          SizedBox(width: 8),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                // DateFormat('HH:mm').format(conversation.lastMessageTime),
                chatMessage.lastMessageTime.toString().substring(11, 16),
                style: TextStyle(color: Colors.grey[350], fontSize: 14),
              ),
              if (chatMessage.unreadCount > 0) ...[
                SizedBox(height: 4),
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: AppColors.accentRed,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    chatMessage.unreadCount.toString(),
                    style: TextStyle(
                      color: AppColors.accentWhite,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class DateFormat {}
