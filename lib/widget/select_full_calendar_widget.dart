import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class SelectFullCalendarWidget extends StatelessWidget {
  final int monthIndex;

  const SelectFullCalendarWidget({super.key, required this.monthIndex});

  @override
  Widget build(BuildContext context) {
    DateTime firstDayOfMonth = DateTime(DateTime.now().year, monthIndex + 1, 1);
    // print(firstDayOfMonth);
    // DateTime lastDayOfMonth = DateTime(DateTime.now().year, monthIndex + 2, 0);
    DateTime today = DateTime.now();

    bool isTodayInMonth = today.year == firstDayOfMonth.year &&
        today.month == firstDayOfMonth.month;

    return TableCalendar(
      firstDay: DateTime(DateTime.now().year, 1, 1),
      lastDay: DateTime(DateTime.now().year, 12, 31),
      startingDayOfWeek: StartingDayOfWeek.monday,
      focusedDay: isTodayInMonth ? today : firstDayOfMonth,
      calendarFormat: CalendarFormat.month,
      onDaySelected: (selectedDay, focusedDay) {},
      calendarStyle: const CalendarStyle(
        outsideDaysVisible: true,
        todayDecoration: BoxDecoration(
          color: Colors.transparent,
        ),
        todayTextStyle: TextStyle(
          color: Colors.blueAccent,
          fontWeight: FontWeight.w800,
        ),
      ),
      headerStyle: const HeaderStyle(
        formatButtonVisible: false,
        leftChevronVisible: false,
        rightChevronVisible: false,
      ),
    );
  }
}
