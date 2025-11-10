import 'package:expenso_422/data/local/helper/db_helper.dart';
import 'package:expenso_422/data/local/model/cat_model.dart';
import 'package:expenso_422/data/local/model/expense_model.dart';
import 'package:expenso_422/data/local/model/filter_expense_model.dart';
import 'package:expenso_422/domain/constants/app_constants.dart';
import 'package:expenso_422/ui/screen/add_expense/bloc/expense_event.dart';
import 'package:expenso_422/ui/screen/add_expense/bloc/expense_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  DBHelper dbHelper;


  ExpenseBloc({required this.dbHelper}) : super(ExpenseInitialState()) {
    on<AddExpenseEvent>((event, emit) async {
      emit(ExpenseLoadingState());

      bool isAdded = await dbHelper.addExpense(newExpense: event.newExp);

      if (isAdded) {
        var allExp = await dbHelper.getAllExpenses();
        emit(ExpenseLoadedState(allExp: filterAllExp(allExp, 1)));
      } else {
        emit(ExpenseErrorState(errorMsg: "Something went wrong"));
      }
    });

    on<FetchInitialExpenseEvent>((event, emit) async {
      emit(ExpenseLoadingState());

      var allExp = await dbHelper.getAllExpenses();
      emit(ExpenseLoadedState(allExp: filterAllExp(allExp, event.filterFlag)));
    });
  }

  List<FilterExpenseModel> filterAllExp(
    List<ExpenseModel> allExpenses,
    int flag,
  ) {
    List<FilterExpenseModel> filteredExpenses = [];

    ///filter == 1
    ///date wise
    if(flag<4) {
      DateFormat df = DateFormat.y();
      if(flag==1) {
        df = DateFormat.yMMMMd();
      } else if(flag==2){
        df = DateFormat.yMMMM();
      }

      ///uniqueDate
      List<String> uniqueDates = [];

      for (ExpenseModel eachExp in allExpenses) {
        String eachDate = df.format(
          DateTime.fromMillisecondsSinceEpoch(eachExp.createdAt),
        );
        if (!uniqueDates.contains(eachDate)) {
          uniqueDates.add(eachDate);
        }
      }

      for (String eachUniqueDate in uniqueDates) {
        num totalExp = 0.0;
        List<ExpenseModel> eachDateExp = [];

        for (ExpenseModel eachExp in allExpenses) {
          String eachDate = df.format(
            DateTime.fromMillisecondsSinceEpoch(eachExp.createdAt),
          );

          if (eachUniqueDate == eachDate) {
            eachDateExp.add(eachExp);

            if (eachExp.expType == 1) {
              totalExp -= eachExp.amt;
            } else {
              totalExp += eachExp.amt;
            }
          }
        }

        filteredExpenses.add(
          FilterExpenseModel(
            title: eachUniqueDate,
            balance: totalExp,
            eachTitleExp: eachDateExp,
          ),
        );
      }
    }
    else {
      ///cat wise
      List<CatModel> uniqueCats = AppConstants.allCat;

      for(CatModel eachCat in uniqueCats){
        num totalExp = 0.0;
        List<ExpenseModel> eachDateExp = [];

        for(ExpenseModel eachExp in allExpenses){
          if(eachExp.catId==eachCat.id){
            eachDateExp.add(eachExp);

            if (eachExp.expType == 1) {
              totalExp -= eachExp.amt;
            } else {
              totalExp += eachExp.amt;
            }
          }
        }

        filteredExpenses.add(
          FilterExpenseModel(
            title: eachCat.title,
            balance: totalExp,
            eachTitleExp: eachDateExp,
          ),
        );
      }
    }

    return filteredExpenses;
  }
}
