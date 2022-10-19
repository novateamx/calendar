import 'dart:convert';

import 'package:calendar/model/calendar_event.dart';
import 'package:http/http.dart' as http;

class EventProvider {
  //https://www.jsonkeeper.com/b/JZON

  Future<CalendarEvent> getEvent() async {
    final response =
        await http.get(Uri.parse('https://www.jsonkeeper.com/b/JZON'));

    if (response.statusCode == 200) {
      final eventJson = json.decode(response.body);
      return CalendarEvent.fromJson(eventJson);
    } else {
      throw Exception('Error fetching event');
    }
  }
}
