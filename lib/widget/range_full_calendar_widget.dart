import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sk/view_model/range_full_calendar_widget_view_model.dart';
import 'package:table_calendar/table_calendar.dart';

class RangeFullCalendarWidget extends StatelessWidget {
  final DateTime _firstDay;
  final DateTime _lastDay;
  final DateTime _focusedDay = DateTime.now();

  RangeFullCalendarWidget({
    Key? key,
    DateTime? firstDay,
    DateTime? lastDay,
  })  : _firstDay = firstDay ??
            DateTime(DateTime.now().year - 1, DateTime.now().month, 1),
        _lastDay = lastDay ??
            DateTime(DateTime.now().year + 1, DateTime.now().month, 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RangeFullCalendarWidgetViewModel>(
      create: (_) => RangeFullCalendarWidgetViewModel(),
      builder: (context, child) {
        return Consumer<RangeFullCalendarWidgetViewModel>(
          builder: (_, rangeFullCalendarWidgetViewModel, __) {
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
                            rangeStartDay:
                                rangeFullCalendarWidgetViewModel.rangeStartDay,
                            rangeEndDay:
                                rangeFullCalendarWidgetViewModel.rangeEndDay,
                            focusedDay: _focusedDay,
                            calendarFormat: CalendarFormat.month,
                            rangeSelectionMode: RangeSelectionMode.toggledOn,
                            onRangeSelected: (start, end, focusedDay) {
                              if (start != null) {
                                rangeFullCalendarWidgetViewModel
                                    .setRangeStartDay(start);
                              }
                              if (end != null) {
                                rangeFullCalendarWidgetViewModel
                                    .setRangeEndDay(end);
                              }
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
                                        style: const TextStyle(
                                            color: Colors.white),
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
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                '오늘로 이동',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              SizedBox(
                                width: 130,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    shape: WidgetStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                    backgroundColor:
                                        WidgetStateProperty.resolveWith<Color>(
                                      (Set<WidgetState> states) {
                                        if (states
                                            .contains(WidgetState.pressed)) {
                                          return Colors.grey; // 버튼 클릭 시 배경색
                                        }
                                        return Colors.blueAccent; // 기본 배경색
                                      },
                                    ),
                                    foregroundColor:
                                        WidgetStateProperty.resolveWith<Color>(
                                      (Set<WidgetState> states) {
                                        if (states
                                            .contains(WidgetState.pressed)) {
                                          return Colors.white30; // 버튼 클릭 시 글자색
                                        }
                                        return Colors.white; // 기본 글자색
                                      },
                                    ),
                                  ),
                                  onPressed: () {
                                    rangeFullCalendarWidgetViewModel
                                        .setRangeText(
                                            rangeFullCalendarWidgetViewModel
                                                .rangeStartDay,
                                            rangeFullCalendarWidgetViewModel
                                                .rangeEndDay);
                                    // TODO: 상위 위젯으로 전달, 프로바이더 중첩... 뭔가 이상...
                                    context.pop();
                                  },
                                  child: Text('선택'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
