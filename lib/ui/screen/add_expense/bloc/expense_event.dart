import 'package:expenso_422/data/local/model/expense_model.dart';

abstract class ExpenseEvent {}

class AddExpenseEvent extends ExpenseEvent{
  ExpenseModel newExp;
  AddExpenseEvent({required this.newExp});
}

class FetchInitialExpenseEvent extends ExpenseEvent{
  ///1->date wise
  ///2->month wise
  ///3->year wise
  ///4->cat wise
  int filterFlag;
  FetchInitialExpenseEvent({this.filterFlag=1});
}


