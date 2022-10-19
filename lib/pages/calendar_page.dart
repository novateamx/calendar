import 'package:calendar/cubit/event_cubit.dart';
import 'package:calendar/cubit/event_state.dart';
import 'package:calendar/model/calendar_event.dart';
import 'package:calendar/widgets/event_icon.dart';
import 'package:calendar/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late DateTime _currentDate;

  final EventList<Event> _markedDateMap = EventList<Event>(events: {});

  static const String GREY_MARKS = 'GREY';
  static const String YELLOW_MARKS = 'YELLOW';
  static const String GREEN_MARKS = 'GREEN';

  @override
  void initState() {
    context.read<EventCubit>().loadEvent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventCubit, EventState>(
      builder: ((context, state) {
        CalendarEvent? event;
        if (state is EventLoadingState) {
          return const LoadingWidget();
        } else if (state is EventErrorState) {
          return ErrorWidget(state.message);
        } else if (state is EventLoadedState) {
          event = state.calendarEvent;
        }

        if (event == null) {
          return const LoadingWidget();
        } else {
          return Container(
            margin:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: _calendarCarousel(event),
          );
        }
      }),
    );
  }

  Widget _calendarCarousel(CalendarEvent data) {
    List<String> greyMarks = data.grey;
    List<String> yellowMarks = data.yellow;
    List<String> greenMarks = data.green;

    String month = data.date.substring(0, 2);
    String year = data.date.substring(3);
    _currentDate = _buildDateTime(
      _parseStringToInt(year),
      _parseStringToInt(month),
      2,
    );
    addAllMarksToDateMap(_currentDate, greyMarks, GREY_MARKS);
    addAllMarksToDateMap(_currentDate, yellowMarks, YELLOW_MARKS);
    addAllMarksToDateMap(_currentDate, greenMarks, GREEN_MARKS);

    return CalendarCarousel<Event>(
      onDayPressed: (date, events) {
        for (var element in events) {
          showSnackbar(element.date.day);
        }
      },
      pageScrollPhysics: const NeverScrollableScrollPhysics(),
      weekendTextStyle: const TextStyle(
        color: Colors.red,
      ),
      weekdayTextStyle: const TextStyle(color: Colors.grey),
      thisMonthDayBorderColor: Colors.transparent,
      weekFormat: false,
      markedDatesMap: _markedDateMap,
      markedDateShowIcon: false,
      height: 400.0,
      selectedDateTime: _currentDate,
      selectedDayButtonColor: Colors.transparent,
      selectedDayTextStyle: const TextStyle(color: Colors.black),
      selectedDayBorderColor: Colors.grey,
      daysHaveCircularBorder: true,
      showHeader: false,
      firstDayOfWeek: 1,
    );
  }

  void addAllMarksToDateMap(
    DateTime dateTime,
    List<String> marks,
    String type,
  ) {
    var date = dateTime;
    for (var mark in marks) {
      date = _buildDateTime(
        dateTime.year,
        dateTime.month,
        _parseStringToInt(mark),
      );
      _markedDateMap.add(
        date,
        Event(
          date: date,
          title: 'Event',
          dot: EventIcon(
            day: mark,
            backgroundColor: getEventBackgroundColor(type),
            textColor: getEventTextColor(type),
          ),
        ),
      );
    }
  }

  Color getEventTextColor(String type) {
    switch (type) {
      case GREY_MARKS:
        return Colors.black;
      default:
        return Colors.white;
    }
  }

  Color getEventBackgroundColor(String type) {
    switch (type) {
      case YELLOW_MARKS:
        return Colors.yellow.shade700;
      case GREEN_MARKS:
        return Colors.green;
      default:
        return Colors.grey.shade200;
    }
  }

  DateTime _buildDateTime(int year, int month, int day) {
    return DateTime(year, month, day);
  }

  int _parseStringToInt(String source) {
    var value = int.tryParse(source);
    return value!;
  }

  void showSnackbar(int day) {
    SnackBar snackBar = SnackBar(content: Text('Day of month: $day'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
