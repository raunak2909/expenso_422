class ExpenseModel{
  int? id;
  int userId;
  String title;
  String desc;
  num amt;
  num bal;
  int expType; ///1->Debit, 2->Credit
  int catId;
  int createdAt;

  ExpenseModel({
    this.id,
    required this.userId,
    required this.title,
    required this.desc,
    required this.amt,
    required this.bal,
    required this.expType,
    required this.catId,
    required this.createdAt,
});
}