import 'package:flutter/material.dart';
import 'package:potential/core/constants/colors.dart';
import 'package:potential/features/chat/helpers/chat_helper.dart';
import 'package:potential/features/chat/models/event.dart';
import 'package:potential/features/chat/services/event_service.dart';
import 'package:potential/features/chat/widgets/chat_profiles.dart';
import 'package:potential/features/chat/widgets/conversation_profiles.dart';
import 'package:potential/features/chat/widgets/event_card.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late final List<EventModel> upcomingEvents;

  @override
  void initState() {
    super.initState();
    upcomingEvents = EventService.getUpcomingEvents();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.bgBlack,
      appBar: AppBar(
        backgroundColor: AppColors.bgBlack,
        elevation: 0,
        title: Text(
          "Chats",
          style: TextStyle(
            color: AppColors.accentWhite,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // USER MATCHES
                Text(
                  "Your Matches",
                  style: TextStyle(
                    color: AppColors.accentWhite,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ChatProfiles(profiles: ChatDataClass.getYourMatches()),
                SizedBox(height: 10),
                Divider(
                  height: 20,
                  thickness: 2,
                  endIndent: 7,
                  color: Colors.grey[600],
                ),

                // USER CHATS
                Text(
                  "Your Chats",
                  style: TextStyle(
                    color: AppColors.accentWhite,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ConversationProfiles(chatMessages: ChatDataClass.getAllChats()),
                SizedBox(height: 10),
                Divider(
                  height: 20,
                  thickness: 2,
                  endIndent: 7,
                  color: Colors.grey[600],
                ),

                // EVENTS LINED UP
                Text(
                  "Events Lined Up! (COMING SOON)",
                  style: TextStyle(
                    color: AppColors.accentWhite,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    spacing: height * 0.02,
                    children: List.generate(upcomingEvents.length, (index) {
                      return EventCard(event: upcomingEvents[index]);
                    }),
                  ),
                ),
                SizedBox(height: height * 0.2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
