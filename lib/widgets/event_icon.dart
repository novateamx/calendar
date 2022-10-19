import 'package:flutter/material.dart';

class EventIcon extends StatelessWidget {
  const EventIcon({
    Key? key,
    required this.day,
    required this.backgroundColor,
    required this.textColor,
  }) : super(key: key);

  final String day;
  final Color textColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(18)),
        ),
        child: Center(
          child: Text(
            day,
            style: TextStyle(color: textColor),
          ),
        ),
      ),
    );
  }
}
