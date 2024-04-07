import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../entity/plan_entity.dart';

class PlanSummaryWidget extends StatelessWidget {
  final PlanEntity plan;

  const PlanSummaryWidget({super.key, required this.plan});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          const SizedBox(width: 20),
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle, // 원형 모양의 배경
              color: Colors.grey[200], // 배경색
            ),
            child: Center(
              child: Text(
                plan.icon,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  plan.name,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 20),
                  child: Text(
                    '${plan.totalExpenses}원',
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              ],
            ),
          ),
          Row(
            children: [
              Text(
                '${plan.calculateLeftAmount()}원',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: plan.type == 'FREE'
                      ? const Color(0XFF40BE40)
                      : Colors.grey,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                plan.type == 'FREE' ? '수입' : '남음',
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(width: 20),
            ],
          ),
        ],
      ),
    );
  }
}
