import 'package:calendar/cubit/event_cubit.dart';
import 'package:calendar/pages/home_page.dart';
import 'package:calendar/services/event_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'pages/calendar_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EventCubit>(
      create: ((context) => EventCubit(eventRepository: EventRepository())),
      child: MaterialApp(
        home: HomePage(),
      ),
    );
  }
}
