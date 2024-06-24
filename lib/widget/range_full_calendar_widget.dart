import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sk/view_model/range_full_calendar_widget_view_model.dart';
import 'package:table_calendar/table_calendar.dart';

import '../view_model/add_plan_view_model.dart';

class RangeFullCalendarWidget extends StatelessWidget {
  final DateTime _firstDay;
  final DateTime _lastDay;

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
          builder: (context, rangeFullCalendarWidgetViewModel, __) {
            // print(rangeFullCalendarWidgetViewModel.focusDay);
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
                            focusedDay:
                                rangeFullCalendarWidgetViewModel.focusDay,
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
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold,
                              ),
                              rangeHighlightColor:
                                  Colors.transparent.withOpacity(0.05),
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
                                      color: Colors.black,
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
                                      color: Colors.black,
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
                              withinRangeBuilder: (context, day, focusedDay) {
                                return Center(
                                  child: Container(
                                    margin: const EdgeInsets.all(4.0),
                                    decoration: const BoxDecoration(
                                      color: Colors.transparent,
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
                              RichText(
                                text: TextSpan(
                                  text: '오늘로 이동',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    decoration: TextDecoration.underline,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      rangeFullCalendarWidgetViewModel
                                          .setFocusDay(DateTime.now());
                                    },
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
                                    context
                                        .read<AddPlanViewModel>()
                                        .setStartDay(
                                            rangeFullCalendarWidgetViewModel
                                                .rangeStartDay);

                                    context.read<AddPlanViewModel>().setEndDay(
                                        rangeFullCalendarWidgetViewModel
                                            .rangeEndDay);
                                    context.pop();
                                  },
                                  child: const Text('선택'),
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
