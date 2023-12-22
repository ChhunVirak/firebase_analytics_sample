import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../utils/extensions/random_extension.dart';

class TableCalendarScreen extends StatefulWidget {
  const TableCalendarScreen({super.key});

  @override
  State<TableCalendarScreen> createState() => _TableCalendarScreenState();
}

class _TableCalendarScreenState extends State<TableCalendarScreen> {
  CalendarFormat calendarFormat = CalendarFormat.month;
  DateTime? selectDay;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TableCalendar(
              firstDay: DateTime.now().subtract(
                const Duration(days: 365),
              ),
              calendarFormat: calendarFormat,
              onFormatChanged: (format) {
                calendarFormat = CalendarFormat.values.next(calendarFormat);
                setState(() {});
              },
              currentDay: selectDay,
              focusedDay: DateTime.now(),
              lastDay: DateTime.now().add(
                const Duration(days: 365),
              ),
              onDaySelected: (selectedDay, focusedDay) {
                selectDay = selectedDay;
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }
}
