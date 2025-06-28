import 'package:potential/features/arena/helpers/arena_helper.dart';

class ChatMessageModel {
  final ArenaProfile participateProfile;
  final String lastMessage;
  final DateTime lastMessageTime;
  final int unreadCount;

  ChatMessageModel({
    required this.participateProfile,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.unreadCount,
  });
}