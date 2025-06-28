import 'package:potential/features/chat/models/event.dart';

class EventController {
  List<EventModel> getUpcomingEvents() {
    return [
      EventModel(
        eventName: "Retro Music Night",
        eventImage:
            "https://media.istockphoto.com/id/1289781422/photo/karaoke-night-vintage-microphone-icon-glowing-purple-violet-neon-text-on-brick-wall.jpg?s=612x612&w=0&k=20&c=51jaFS0iWPh700TFpXQvm50x6g-7NtKP4TpDmRESMwI=",
        eventTags: ["Music", "Party", "Karaoke"],
        eventTime: DateTime.now(),
        eventDate: "TODAY",
        eventLocation: "Invincible Boudir & Jardin",
        eventRatings: 4.5,
        eventParticipants: [
          "https://via.placeholder.com/150",
          "https://via.placeholder.com/150",
        ],
        eventPartnerName: "ThatzwhatShe_Said",
        eventDistanceFromUser: 5.9,
      ),
      EventModel(
        eventName: "Brain Session",
        eventImage:
            "https://shelovesdata.com/wp-content/uploads/2024/11/INDIA_GenAI-Hackathon-2024_Web_LN_FB_Banner_1200-x-628-px_1.jpg",
        eventTags: ["AI", "Hackathon", "GenAI"],
        eventTime: DateTime.now(),
        eventDate: "TOMORROW",
        eventLocation: "TBD",
        eventRatings: 4.2,
        eventParticipants: [
          "https://via.placeholder.com/150",
          "https://via.placeholder.com/150",
          "https://via.placeholder.com/150",
        ],
        eventPartnerName: "HardCoreRocky",
        eventDistanceFromUser: 10.2,
      ),
    ];
  }
}
