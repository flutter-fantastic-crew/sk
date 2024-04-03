import 'package:sk/entity/plan_history_entity.dart';

class PlanEntity {
  int id; // 아이디
  DateTime startDate; // 시작일
  DateTime endDate; // 종료일
  String type; // 타입 (계획 / 자유)
  String name; // 이름
  String memo; // 설명 (메모)
  String icon; // 아이콘
  List<PlanHistoryEntity> planHistory; // 소비지출 기록 리스트
  int totalAmount; // 총 금액

  PlanEntity({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.type,
    required this.name,
    required this.memo,
    required this.icon,
    required this.planHistory,
    required this.totalAmount,
  });

  int get totalExpenses => planHistory
      .where((e) => e.type == "EXPENSE")
      .map((e) => e.amount)
      .reduce((sum, value) => sum + value);

  int get totalIncomes => planHistory
      .where((e) => e.type == 'INCOME')
      .map((e) => e.amount)
      .reduce((sum, value) => sum + value);

  int calculateLeftAmount(PlanEntity plan) {
    int leftAmount = 0;

    if (plan.type == 'FREE') {
      for (var history in plan.planHistory) {
        if (history.type == 'INCOME') {
          leftAmount += history.amount;
        }
      }
    } else if (plan.type == 'SET') {
      return plan.totalAmount;
    }

    return leftAmount;
  }
}
