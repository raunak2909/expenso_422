import 'package:expenso_422/data/local/helper/db_helper.dart';
import 'package:expenso_422/ui/screen/add_expense/bloc/expense_event.dart';
import 'package:expenso_422/ui/screen/add_expense/bloc/expense_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState>{
  DBHelper dbHelper;
  ExpenseBloc({required this.dbHelper}) :super(ExpenseInitialState()){

    on<AddExpenseEvent>((event, emit) async{

      emit(ExpenseLoadingState());

      bool isAdded = await dbHelper
          .addExpense(newExpense: event.newExp);

      if(isAdded){
        var allExp = await dbHelper.getAllExpenses();
        emit(ExpenseLoadedState(allExp: allExp));
      } else {
        emit(ExpenseErrorState(errorMsg: "Something went wrong"));
      }

    });

    on<FetchInitialExpenseEvent>((event, emit) async{

      emit(ExpenseLoadingState());

      var allExp = await dbHelper.getAllExpenses();
      emit(ExpenseLoadedState(allExp: allExp));
    });

  }

}