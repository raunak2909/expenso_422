import 'package:expenso_422/data/local/model/expense_model.dart';

class FilterExpenseModel{
  String title;
  num balance;
  List<ExpenseModel> eachTitleExp;

  FilterExpenseModel({
    required this.title,
    required this.balance,
    required this.eachTitleExp,
  });

}