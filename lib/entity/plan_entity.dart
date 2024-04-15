import 'package:sk/entity/plan_history_entity.dart';

class PlanEntity {
  int id; // 아이디
  DateTime startDate; // 시작일
  DateTime endDate; // 종료일
  PlanType type; // 타입 (계획 / 자유)
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

  int get totalExpenses {
    final incomeData =
        planHistory.where((e) => e.type == PlanHistoryType.expense).toList();
    return incomeData
        .map((e) => e.amount)
        .fold(0, (sum, value) => sum + value); // 시작값 지정
  }

  int calculateLeftAmount() {
    int leftAmount = 0;
    if (type == PlanType.free) {
      leftAmount = planHistory
          .where((history) => history.type == PlanHistoryType.income)
          .map((history) => history.amount)
          .fold(0, (sum, amount) => sum + amount);
    } else {
      final expense = planHistory
          .where((history) => history.type == PlanHistoryType.expense)
          .map((history) => history.amount)
          .fold(0, (sum, amount) => sum + amount);
      leftAmount = totalAmount - expense;
    }
    return leftAmount;
  }
}

enum PlanType { set, free }
