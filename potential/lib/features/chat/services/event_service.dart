import 'package:potential/features/chat/controller/event_controller.dart';
import 'package:potential/features/chat/models/event.dart';

class EventService {
  static List<EventModel> getUpcomingEvents() => EventController().getUpcomingEvents();
}