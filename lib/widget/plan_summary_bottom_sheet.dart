import 'package:flutter/material.dart';
import 'package:sk/widget/total_amount_widget.dart';

class PlanSummeryBottomSheet extends StatelessWidget {
  const PlanSummeryBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      //상위 부모의 사이즈 비율을 지정하여 child의 크기를 정하기
      heightFactor: 0.88,
      child: Column(
        children: <Widget>[
          const SizedBox(height: 10),
          GestureDetector(
            child: Container(
              width: 40,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.only(left: 15),
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '요약',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 15, right: 7.5),
                  child: const TotalAmountWidget(
                    title: '총 소비',
                    amount: '1,000',
                    color: Color(0xFF202B33),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 7.5, right: 15),
                  child: const TotalAmountWidget(
                    title: '총 수입',
                    amount: '1,000',
                    color: Color(0XFF40BE40),
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 70,
            margin: const EdgeInsets.all(15),
            padding: const EdgeInsets.all(17),
            decoration: BoxDecoration(
              color: const Color(0xFFEAEAEA),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Row(
              // betweenSpace
              // row에 row를 쓰는 방법도 있음
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '남은 총 예산',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(width: 18),
                Expanded(
                  child: Text(
                    '5,000원',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF202B33),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '/ 5,000원',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      // 플랜별 소비 위젯 만들기!
    );
  }
}
