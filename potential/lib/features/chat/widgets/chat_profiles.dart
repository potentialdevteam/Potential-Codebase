import 'package:flutter/material.dart';
import 'package:potential/core/configs/fade_route_transition.dart';
import 'package:potential/core/constants/colors.dart';
import 'package:potential/features/chat/helpers/chat_helper.dart';
import 'package:potential/features/chat/views/first_move.dart';

class ChatProfiles extends StatelessWidget {
  final List<ChatProfile> profiles;
  const ChatProfiles({super.key, required this.profiles});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (profiles.isEmpty) {
      return SizedBox.shrink(
        child: Text(
          "No Matches Yet! Don't lose hope!",
          style: TextStyle(color: AppColors.accentWhite, fontSize: 16),
        ),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: profiles
            .map(
              (profile) => Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                child: _buildChatProfiles(profile, context),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildChatProfiles(ChatProfile profile, BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        FadeRouteTransition(
          dest: FirstMoveScreen(
            matchedUserProfileUrl:
                "https://images.pexels.com/photos/2379004/pexels-photo-2379004.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
            matchedUserName: "Priya",
            userProfileUrl:
                "https://thumbs.dreamstime.com/b/profile-picture-young-indian-woman-renter-headshot-portrait-confident-tenant-pose-modern-own-new-apartment-house-226719004.jpg",
            firstMovePrompt: "What's your favourite movie?",
          ),
        ),
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.2,
        height: MediaQuery.of(context).size.width * 0.3,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    const Color.fromARGB(255, 255, 255, 255),
                    const Color.fromARGB(255, 230, 116, 116),
                    const Color.fromARGB(255, 196, 33, 44),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.bgBlack, width: 3),
              ),
              child: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(profile.profilePictureUrl),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
