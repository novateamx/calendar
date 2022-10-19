class CalendarEvent {
  String date;
  List<String> green;
  List<String> yellow;
  List<String> grey;

  CalendarEvent({
    required this.date,
    required this.green,
    required this.yellow,
    required this.grey,
  });

  factory CalendarEvent.fromJson(Map<String, dynamic> json) {
    return CalendarEvent(
      date: json['date'],
      green: json['green'].cast<String>(),
      yellow: json['yellow'].cast<String>(),
      grey: json['grey'].cast<String>(),
    );
  }
}
