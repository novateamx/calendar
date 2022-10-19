import 'package:calendar/cubit/event_state.dart';
import 'package:calendar/services/event_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventCubit extends Cubit<EventState> {
  EventCubit({required this.eventRepository}) : super(EventLoadingState());

  final EventRepository eventRepository;

  void loadEvent() async {
    try {
      final event = await eventRepository.getEvent();
      emit(EventLoadedState(calendarEvent: event));
    } catch (e) {
      emit(EventErrorState(message: e.toString()));
    }
  }
}
