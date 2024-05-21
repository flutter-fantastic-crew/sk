import 'dart:math';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class RangeFullCalendarWidget extends StatefulWidget {
  const RangeFullCalendarWidget({super.key});

  @override
  State<RangeFullCalendarWidget> createState() => _RangeFullCalendarWidget();
}

// 기간 선택이 가능한 달력 추가
class _RangeFullCalendarWidget extends State<RangeFullCalendarWidget> {
  final DateTime _firstDay =
      DateTime(DateTime.now().year - 1, DateTime.now().month, 1);
  final DateTime _lastDay =
      DateTime(DateTime.now().year + 1, DateTime.now().month, 0);
  DateTime _focusedDay = DateTime.now();
  DateTime? _rangeStartDay;
  DateTime? _rangeEndDay;

  // DateTime? _selectedDay;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;

  Random random = Random();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.66,
      child: Scrollbar(
        child: SingleChildScrollView(
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
                    rangeStartDay: _rangeStartDay,
                    rangeEndDay: _rangeEndDay,
                    focusedDay: _focusedDay,
                    calendarFormat: CalendarFormat.month,
                    rangeSelectionMode: _rangeSelectionMode,
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        if (_rangeSelectionMode ==
                            RangeSelectionMode.toggledOn) {
                          _rangeStartDay = null;
                          _rangeEndDay = null;
                          _rangeSelectionMode = RangeSelectionMode.toggledOff;
                        } else {
                          _focusedDay = focusedDay;
                          _rangeSelectionMode = RangeSelectionMode.toggledOn;
                        }
                      });
                    },
                    onRangeSelected: (start, end, focusedDay) {
                      setState(() {
                        _rangeStartDay = start;
                        _rangeEndDay = end;
                        _focusedDay = focusedDay;
                        _rangeSelectionMode = RangeSelectionMode.toggledOn;
                      });
                    },
                    calendarStyle: CalendarStyle(
                      outsideDaysVisible: true,
                      todayDecoration: const BoxDecoration(
                        color: Colors.transparent,
                      ),
                      todayTextStyle: const TextStyle(
                        color: Colors.black,
                      ),
                      rangeHighlightColor: Colors.blue.withOpacity(0.5),
                      rangeStartDecoration: const BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      rangeEndDecoration: const BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      withinRangeDecoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                    ),
                    headerStyle: const HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                    ),
                    calendarBuilders: CalendarBuilders(
                      rangeStartBuilder: (context, day, focusedDay) {
                        return Center(
                          child: Container(
                            margin: const EdgeInsets.all(4.0),
                            decoration: const BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                            ),
                            width: 36.0,
                            height: 36.0,
                            child: Center(
                              child: Text(
                                '${day.day}',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        );
                      },
                      rangeEndBuilder: (context, day, focusedDay) {
                        return Center(
                          child: Container(
                            margin: const EdgeInsets.all(4.0),
                            decoration: const BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                            ),
                            width: 36.0,
                            height: 36.0,
                            child: Center(
                              child: Text(
                                '${day.day}',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        );
                      },
                      withinRangeBuilder: (context, day, focusedDay) {
                        return Center(
                          child: Container(
                            margin: const EdgeInsets.all(4.0),
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            width: 36.0,
                            height: 36.0,
                            child: Center(
                              child: Text(
                                '${day.day}',
                                style: const TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
