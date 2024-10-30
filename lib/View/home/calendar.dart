import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => CalendarState();
}

class CalendarState extends State<Calendar> {
  final Map<DateTime, List> _events = {};
  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.now();

  @override
  void initState() {
    DateTime d = DateTime.utc(2024, 10, 31);
    DateTime e = DateTime.utc(2024, 11, 1);
    _events[d] = ["Event A"];
    _events[e] = ["Event B"];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("My Course:"),
              CircleAvatar(
                minRadius: 10,
                backgroundColor: Colors.blue,
              ),
              Text("Ended Course:"),
              CircleAvatar(
                backgroundColor: Colors.red,
                minRadius: 10,
              )
            ],
          ),
        ),
        TableCalendar(
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          },
          eventLoader: (day) {
            return _events[day] ?? [];
          },
          focusedDay: DateTime.now(),
          firstDay: DateTime.utc(2010, 12, 31),
          lastDay: DateTime.utc(2040, 01, 01),
          calendarStyle: CalendarStyle(
              markerDecoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(50))),
        ),
      ],
    ));
  }
}
