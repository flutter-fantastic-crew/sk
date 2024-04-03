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
        type: "FREE",
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        memo: "소비계획1메모",
        name: "소비계획1",
        icon: "😀",
        planHistory: [
          PlanHistoryEntity(
            id: 0,
            type: "EXPENSE",
            memo: "메모1",
            createAt: DateTime.now(),
            amount: 100,
          ),
          PlanHistoryEntity(
            id: 1,
            type: "INCOME",
            memo: "메모2",
            createAt: DateTime.now(),
            amount: 200,
          )
        ],
        totalAmount: 1000),
    PlanEntity(
        id: 1,
        type: 'SET',
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        memo: "소비계획2메모",
        name: "소비계획2",
        icon: "😍",
        planHistory: [
          PlanHistoryEntity(
            id: 0,
            type: "EXPENSE",
            memo: "메모1",
            createAt: DateTime.now(),
            amount: 100,
          ),
          PlanHistoryEntity(
            id: 1,
            type: "EXPENSE",
            memo: "메모2",
            createAt: DateTime.now(),
            amount: 200,
          )
        ],
        totalAmount: 1000)
  ];

  List<PlanEntity> get plans => _plans; // 접근제어자에 대한 get만 허용

  int _currentPage = 0;
  int get currentPage => _currentPage;

  void changePage(int currentPage) {
    _currentPage = currentPage;
    notifyListeners(); // 컨슈밍하고 있는 대상에게 리빌딩 하도록 알려줌
  }

  void addPlan(PlanEntity plan) {
    _plans.add(plan);
    notifyListeners();
  }
}
