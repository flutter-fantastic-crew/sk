import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:sk/entity/plan_entity.dart';
import 'dart:math' as math;

class PlanCardWidget extends StatelessWidget {
  final PlanEntity plan;

  const PlanCardWidget({super.key, required this.plan});

  @override
  Widget build(BuildContext context) {
    final numberFormat = NumberFormat('###,###,###,###'); // 나라를 지정하는 방법.
    return Container(
      padding: const EdgeInsets.all(50),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                plan.icon,
                style: const TextStyle(
                  fontSize: 22,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                plan.name,
                style: const TextStyle(
                  fontSize: 17,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularPercentIndicator(
                  radius: 130.0,
                  lineWidth: 2.0,
                  percent: plan.getLeftDatePercent(),
                  backgroundColor: const Color(0XFFEEEEEE),
                  progressColor: Colors.black87,
                  center: Stack(
                    alignment: Alignment.center,
                    children: [
                      Transform.translate(
                        offset: Offset(
                          (130 *
                              math.cos(2 * math.pi * plan.getLeftDatePercent() -
                                  math.pi / 2)), // X 좌표 계산
                          (130 *
                              math.sin(2 * math.pi * plan.getLeftDatePercent() -
                                  math.pi / 2)), // Y 좌표 계산
                        ),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.access_time_filled,
                            color: Colors.black,
                            size: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                plan.type == PlanType.set
                    ? CircularPercentIndicator(
                        radius: 120.0,
                        lineWidth: 12.0,
                        percent: 0.1,
                        backgroundColor: const Color(0XffEEEEEE),
                        progressColor: Colors.blue,
                        circularStrokeCap: CircularStrokeCap.round,
                        // center:
                      )
                    : const SizedBox(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '남은 예산',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${numberFormat.format(plan.totalExpenses)}원',
                          style: const TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        const Icon(
                          CupertinoIcons.chevron_compact_right,
                          size: 18,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      '/ ${numberFormat.format(plan.totalAmount)}원',
                      style: const TextStyle(
                        fontSize: 17,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), // 반경 설정
            ),
            child: ElevatedButton(
              onPressed: () {
                context.push('/addHistory');
              },
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(
                  const EdgeInsets.all(15),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(10), // 버튼 모양과 일치시키기 위해 중복 설정
                  ),
                ),
                backgroundColor: MaterialStateProperty.all<Color>(
                  const Color(0xFF3D83F0),
                ),
              ),
              child: const Text(
                '내역 추가',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
