class EventModel{
  final String eventName;
  final String eventImage;
  final List<String> eventTags;
  final DateTime eventTime; // show time in 12 hour format
  final String eventDate; // show TODAY , TOMORROW OR DATE
  final String eventLocation;
  final double eventRatings;
  final List<String> eventParticipants; //list of participants' profile pictures
  final String eventPartnerName;
  final double eventDistanceFromUser;

  EventModel({
    required this.eventName,
    required this.eventImage,
    required this.eventTags,
    required this.eventTime,
    required this.eventDate,
    required this.eventLocation,
    required this.eventRatings,
    required this.eventParticipants,
    required this.eventPartnerName,
    required this.eventDistanceFromUser,
  });
}