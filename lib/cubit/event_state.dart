import 'package:calendar/model/calendar_event.dart';

abstract class EventState {}

class EventLoadingState extends EventState {}

class EventLoadedState extends EventState {
  CalendarEvent calendarEvent;

  EventLoadedState({required this.calendarEvent});
}

class EventErrorState extends EventState {
  final String message;

  EventErrorState({required this.message});
}
