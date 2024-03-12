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
            margin: EdgeInsets.only(left: 10),
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
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TotalAmountWidget(
                  title: '총 소비', amount: '1,000', color: Color(0xFF202B33)),
              TotalAmountWidget(
                  title: '총 수입', amount: '1,000', color: Color(0XFF40BE40)),
            ],
          )
        ],
      ),
    );
  }
}
