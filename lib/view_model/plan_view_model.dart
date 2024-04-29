import 'package:flutter/cupertino.dart';
import 'package:sk/entity/plan_entity.dart';

import '../entity/plan_history_entity.dart';

class PlanViewModel extends ChangeNotifier {
  // 사용자 액션이 일어나면 뷰모델을 호출
  // index가 0인 페이지 먼저 보여줌
  final pageController = PageController(
    initialPage: 0,
  );

  final List<PlanEntity> _plans = [
    PlanEntity(
        id: 0,
        type: PlanType.free,
        startDate: DateTime.now().subtract(const Duration(days:30)),
        endDate: DateTime.now().subtract(const Duration(days:28)),
        memo: "소비계획1메모",
        name: "소비계획1",
        icon: "😀",
        planHistory: [
          PlanHistoryEntity(
            id: 0,
            type: PlanHistoryType.expense,
            memo: "메모1",
            createAt: DateTime.now(),
            amount: 500,
          ),
          PlanHistoryEntity(
            id: 1,
            type: PlanHistoryType.income,
            memo: "메모2",
            createAt: DateTime.now(),
            amount: 600,
          )
        ],
        totalAmount: 0),
    PlanEntity(
        id: 1,
        type: PlanType.set,
        startDate: DateTime.now().subtract(const Duration(days:15)),
        endDate: DateTime.now().subtract(const Duration(days:10)),
        memo: "소비계획2메모",
        name: "소비계획2",
        icon: "😍",
        planHistory: [
          PlanHistoryEntity(
            id: 0,
            type: PlanHistoryType.expense,
            memo: "메모1",
            createAt: DateTime.now(),
            amount: 700,
          ),
          PlanHistoryEntity(
            id: 1,
            type: PlanHistoryType.expense,
            memo: "메모2",
            createAt: DateTime.now(),
            amount: 800,
          )
        ],
        totalAmount: 1000),
    PlanEntity(
        id: 1,
        type: PlanType.set,
        startDate: DateTime.now().subtract(const Duration(days:15)),
        endDate: DateTime.now().add(const Duration(days: 1)),
        memo: "소비계획3메모",
        name: "소비계획3",
        icon: "😇",
        planHistory: [
          PlanHistoryEntity(
            id: 0,
            type: PlanHistoryType.expense,
            memo: "메모1",
            createAt: DateTime.now(),
            amount: 300,
          ),
          PlanHistoryEntity(
            id: 1,
            type: PlanHistoryType.expense,
            memo: "메모2",
            createAt: DateTime.now(),
            amount: 700,
          )
        ],
        totalAmount: 1000),
    PlanEntity(
        id: 1,
        type: PlanType.free,
        startDate: DateTime.now().subtract(const Duration(days:7)),
        endDate: DateTime.now().add(const Duration(days: 3)),
        memo: "자유계획2메모",
        name: "자유계획2",
        icon: "🤓",
        planHistory: [
          PlanHistoryEntity(
            id: 0,
            type: PlanHistoryType.expense,
            memo: "메모1",
            createAt: DateTime.now(),
            amount: 200,
          ),
          PlanHistoryEntity(
            id: 1,
            type: PlanHistoryType.expense,
            memo: "메모2",
            createAt: DateTime.now(),
            amount: 100,
          )
        ],
        totalAmount: 1000),
    PlanEntity(
        id: 1,
        type: PlanType.free,
        startDate: DateTime.now().subtract(const Duration(days:7)),
        endDate: DateTime.now().add(const Duration(days: 3)),
        memo: "자유계획3메모",
        name: "자유계획3",
        icon: "😍",
        planHistory: [
          PlanHistoryEntity(
            id: 1,
            type: PlanHistoryType.income,
            memo: "메모2",
            createAt: DateTime.now(),
            amount: 50,
          )
        ],
        totalAmount: 500),
    PlanEntity(
        id: 1,
        type: PlanType.set,
        startDate: DateTime.now().subtract(const Duration(days:7)),
        endDate: DateTime.now().add(const Duration(days: 3)),
        memo: "소비계획4메모",
        name: "소비계획4",
        icon: "🦾",
        planHistory: [
          PlanHistoryEntity(
            id: 0,
            type: PlanHistoryType.expense,
            memo: "메모1",
            createAt: DateTime.now(),
            amount: 700,
          ),
        ],
        totalAmount: 900),
  ];

  List<PlanEntity> get plans => _plans; // 접근제어자에 대한 get만 허용

  int _currentPage = 0;

  int get currentPage => _currentPage;

  int getTotalAmountByType(PlanHistoryType type) {
    return plans.fold(
        0,
        (total, plan) =>
            total +
            plan.planHistory
                .where((e) => e.type == type)
                .fold(0, (sum, history) => sum + history.amount));
  }

  int getOriginalTotalBudget() {
    return plans
        .where((e) => (e.type == PlanType.set))
        .fold(0, (total, plan) => total + plan.totalAmount);
  }

  int getCurrentBudget() {
    return plans.where((e) => (e.type == PlanType.set)).fold(
        0,
        (total, plan) =>
            total +
            plan.planHistory
                .where((e) => e.type == PlanHistoryType.expense)
                .fold(0, (sum, history) => sum + history.amount));
  }

  void changePage(int currentPage) {
    _currentPage = currentPage;
    notifyListeners(); // 컨슈밍하고 있는 대상에게 리빌딩 하도록 알려줌
  }
}
