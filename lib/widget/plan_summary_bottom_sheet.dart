import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sk/widget/plan_summary_widget.dart';
import 'package:sk/widget/total_amount_widget.dart';
import '../view_model/plan_view_model.dart';

class PlanSummeryBottomSheet extends StatelessWidget {
  const PlanSummeryBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final numberFormat = NumberFormat('###,###,###,###');
    final viewModel = Provider.of<PlanViewModel>(context, listen: false);

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
                  child: TotalAmountWidget(
                    title: '총 소비',
                    amount: numberFormat
                        .format(viewModel.getTotalAmountByType('EXPENSE')),
                    color: const Color(0xFF202B33),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 7.5, right: 15),
                  child: TotalAmountWidget(
                    title: '총 수입',
                    amount: numberFormat
                        .format(viewModel.getTotalAmountByType('INCOME')),
                    color: const Color(0XFF40BE40),
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
            child: Row(
              // betweenSpace
              // row에 row를 쓰는 방법도 있음
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '남은 총 예산',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                  ),
                ),
                const SizedBox(width: 18),
                Expanded(
                  child: Text(
                    numberFormat.format(viewModel.getCurrentBudget()),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF202B33),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '/ ${numberFormat.format(viewModel.getOriginalTotalBudget())}원',
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 15),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 20),
                Text(
                  '플랜별 소비',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Consumer<PlanViewModel>(
              builder: (context, viewModel, child) {
                return ListView.builder(
                  itemCount: viewModel.plans.length,
                  itemBuilder: (context, index) {
                    final plan = viewModel.plans[index];
                    return PlanSummaryWidget(plan: plan);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
