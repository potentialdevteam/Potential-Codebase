import 'package:potential/features/arena/helpers/arena_helper.dart';
import 'package:potential/features/chat/models/chat_message.dart';

class ChatProfile {
  final String profilePictureUrl;

  const ChatProfile({required this.profilePictureUrl});
}

class ChatDataClass {
  static List<ChatProfile> getYourMatches() {
    return [
      ChatProfile(
        profilePictureUrl:
            "https://thumbs.dreamstime.com/b/profile-picture-young-indian-woman-renter-headshot-portrait-confident-tenant-pose-modern-own-new-apartment-house-226719004.jpg",
      ),
      ChatProfile(
        profilePictureUrl:
            "https://thumbs.dreamstime.com/b/profile-picture-young-indian-woman-renter-headshot-portrait-confident-tenant-pose-modern-own-new-apartment-house-226719004.jpg",
      ),
      ChatProfile(
        profilePictureUrl:
            "https://thumbs.dreamstime.com/b/profile-picture-young-indian-woman-renter-headshot-portrait-confident-tenant-pose-modern-own-new-apartment-house-226719004.jpg",
      ),
    ];
  }

  static List<ChatMessageModel> getAllChats() {
    return List.generate(
      5,
      (index) => ChatMessageModel(
        participateProfile: ArenaProfile(
          name: "Jane Doe",
          age: 32,
          profilePictureUrl:
              "https://thumbs.dreamstime.com/b/profile-picture-young-indian-woman-renter-headshot-portrait-confident-tenant-pose-modern-own-new-apartment-house-226719004.jpg",
        ),
        lastMessage: "Hey, what are your plans for the weekend?",
        lastMessageTime: DateTime.now().subtract(Duration(minutes: 10)),
        unreadCount: 1,
      ),
    );
  }
}
