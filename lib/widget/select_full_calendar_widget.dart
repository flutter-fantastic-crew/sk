import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../view_model/add_history_view_model.dart';

class SelectFullCalendarWidget extends StatelessWidget {
  final DateTime _firstDay;
  final DateTime _lastDay;
  final DateTime _now;

  SelectFullCalendarWidget({
    Key? key,
    DateTime? firstDay,
    DateTime? lastDay,
    DateTime? now,
  })  : _firstDay = firstDay ??
            DateTime(DateTime.now().year - 1, DateTime.now().month, 1),
        _lastDay = lastDay ??
            DateTime(DateTime.now().year + 1, DateTime.now().month, 0),
        _now = now ?? DateTime.now(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedDay = context.watch<AddHistoryViewModel>().date;
    final focusedDay = selectedDay;
    return FractionallySizedBox(
      heightFactor: 0.66,
      child: SizedBox(
        height: (MediaQuery.of(context).size.height / 7) * 4.3,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            Container(
              width: 60,
              height: 6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3.0),
                color: const Color(0xFFE0E0E0),
              ),
            ),
            const SizedBox(height: 20.0),
            Expanded(
              child: TableCalendar(
                firstDay: _firstDay,
                lastDay: _lastDay,
                focusedDay: focusedDay,
                calendarFormat: CalendarFormat.month,
                selectedDayPredicate: (day) {
                  return isSameDay(selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  context.read<AddHistoryViewModel>().setDate(selectedDay);
                  context.pop();
                },
                calendarStyle: CalendarStyle(
                    outsideDaysVisible: true,
                    todayDecoration: BoxDecoration(
                      color: isSameDay(focusedDay, _now)
                          ? Colors.black
                          : Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                    selectedDecoration: const BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                    selectedTextStyle: const TextStyle(
                      color: Colors.white,
                    ),
                    todayTextStyle: TextStyle(
                      color: isSameDay(focusedDay, _now)
                          ? Colors.white
                          : Colors.blueAccent,
                    )),
                headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
