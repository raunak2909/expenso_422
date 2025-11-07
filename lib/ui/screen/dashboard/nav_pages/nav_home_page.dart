import 'dart:math';

import 'package:expenso_422/data/local/model/expense_model.dart';
import 'package:expenso_422/domain/constants/app_constants.dart';
import 'package:expenso_422/ui/screen/add_expense/bloc/expense_bloc.dart';
import 'package:expenso_422/ui/screen/add_expense/bloc/expense_event.dart';
import 'package:expenso_422/ui/screen/add_expense/bloc/expense_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class NavHomePage extends StatefulWidget {
  const NavHomePage({super.key});

  @override
  State<NavHomePage> createState() => _NavHomePageState();
}

class _NavHomePageState extends State<NavHomePage> {
  DateFormat tf = DateFormat.jms();

  @override
  void initState() {
    super.initState();
    context.read<ExpenseBloc>().add(FetchInitialExpenseEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ExpenseBloc, ExpenseState>(
        builder: (_, state) {
          if (state is ExpenseLoadingState) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is ExpenseErrorState) {
            return Center(child: Text(state.errorMsg));
          }

          if (state is ExpenseLoadedState) {
            return state.allExp.isNotEmpty
                ? ListView.builder(
                padding: EdgeInsets.zero,
              itemCount: state.allExp.length,
                itemBuilder: (_, index) {
                  return Container(
                    margin: EdgeInsets.all(11),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11),
                      border: Border.all(
                        color: Colors.grey.shade400
                      )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 11,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(state.allExp[index].title, style: TextStyle(fontSize: 16),),
                              Text(state.allExp[index].balance.toString(), style: TextStyle(fontSize: 16),),
                            ],
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Container(
                            color: Colors.grey.shade400,
                            width: double.infinity,
                            height: 1,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          ListView.builder(
                            padding: EdgeInsets.zero,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: state.allExp[index].eachTitleExp.length,
                              itemBuilder: (_, childIndex){
                            ExpenseModel eachExp = state.allExp[index].eachTitleExp[childIndex];

                            String imgPath = AppConstants.allCat.firstWhere((element){
                              return element.id==eachExp.catId;
                            }).imgPath;

                            DateTime eachExpDate = DateTime.fromMillisecondsSinceEpoch(eachExp.createdAt);

                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: Container(
                                padding: EdgeInsets.all(7),
                                  decoration: BoxDecoration(
                                    color: Colors.primaries[Random().nextInt(Colors.primaries.length)].shade100,
                                      borderRadius: BorderRadius.circular(7),
                                  ),
                                  child: Image.asset(imgPath, width: 30, height: 30,)),
                              title: Text(eachExp.title),
                              subtitle: Text(eachExp.desc),
                              trailing: Column(
                                children: [
                                  //Text("${eachExpDate.hour} : ${eachExpDate.minute}"),
                                  Text(tf.format(eachExpDate)),
                                  Text(eachExp.amt.toString()),
                                ],
                              ),
                            );
                          })
                        ],
                      ),
                    ),
                  );
            })
                : Center(child: Text('No Expenses yet!!'));
          }

          return Container();
        },
      ),
    );
  }
}
