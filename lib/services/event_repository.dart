import 'package:calendar/model/calendar_event.dart';
import 'package:calendar/services/event_api_provider.dart';

class EventRepository {
  final EventProvider _userProvider = EventProvider();

  Future<CalendarEvent> getEvent() => _userProvider.getEvent();
}
