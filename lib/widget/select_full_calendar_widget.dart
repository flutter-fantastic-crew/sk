import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../view_model/add_history_view_model.dart';

class SelectFullCalendarWidget extends StatefulWidget {
  const SelectFullCalendarWidget({super.key});

  @override
  State<SelectFullCalendarWidget> createState() => _SelectFullCalendarWidget();
}

class _SelectFullCalendarWidget extends State<SelectFullCalendarWidget> {
  final DateTime _firstDay =
      DateTime(DateTime.now().year - 1, DateTime.now().month, 1);
  final DateTime _lastDay =
      DateTime(DateTime.now().year + 1, DateTime.now().month, 0);
  late DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Random random = Random();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                  focusedDay: _focusedDay,
                  calendarFormat: CalendarFormat.month,
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    context.read<AddHistoryViewModel>().setDate(selectedDay);
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  },
                  calendarStyle: CalendarStyle(
                      outsideDaysVisible: true,
                      todayDecoration: BoxDecoration(
                        color: _selectedDay == null ||
                                isSameDay(_selectedDay, DateTime.now())
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
                        color: _selectedDay == null ||
                                isSameDay(_selectedDay, DateTime.now())
                            ? Colors.white
                            : Colors.black,
                      )),
                  headerStyle: const HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
