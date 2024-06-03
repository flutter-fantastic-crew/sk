class PlanHistoryEntity {
  int id; // 아이디
  PlanHistoryType type; // 타입 (소비 / 수입)
  int amount; // 금액
  String memo; // 메모
  DateTime createAt; // 생성 일자

  PlanHistoryEntity({
    required this.id,
    required this.type,
    required this.amount,
    required this.memo,
    required this.createAt,
  });

  @override
  String toString() {
    return 'PlanHistoryEntity(id: $id, type: $type, memo: $memo, createAt: $createAt, amount: $amount)';
  }
}

enum PlanHistoryType { expense, income }
