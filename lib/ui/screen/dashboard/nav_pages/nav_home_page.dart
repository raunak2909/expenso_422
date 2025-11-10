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

  /// 1. calculate the balance
  /// 2. calculate bal for each transaction
  /// 3. read fl_chart doc and integrate basic bar chart for any random values
  /// 4. build barchart for date-wise exp data




  DateFormat tf = DateFormat.jms();
  List<String> mType = [
    "Date-wise",
    "Month-wise",
    "Year-wise",
    "Category-wise",
  ];
  int selectedType = 1;

  @override
  void initState() {
    super.initState();
    context.read<ExpenseBloc>().add(FetchInitialExpenseEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 11.0),
        child: Column(
          children: [
            headerLay(),
            SizedBox(
              height: 11,
            ),
            mainLay()
          ],
        ),
      ),
    );
  }

  Widget headerLay(){
    return Row(
      children: [
        CircleAvatar(
          radius: 22,
          backgroundColor: Colors.amber.shade200,
          backgroundImage: NetworkImage(
            "https://static.vecteezy.com/system/resources/previews/048/216/761/non_2x/modern-male-avatar-with-black-hair-and-hoodie-illustration-free-png.png",
          ),
        ),
        SizedBox(width: 11),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Morning', style: TextStyle(color: Colors.grey)),
              Text(
                'AKnvsjdhvsdvflmv',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        SizedBox(width: 11),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 11),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(16),
          ),
          child: DropdownButton(
            borderRadius: BorderRadius.circular(21),
            underline: Container(),
            value: selectedType,
            items: List.generate(mType.length, (i) {
              return DropdownMenuItem(
                value: i+1,
                child: Text(mType[i]),
              );
            }),
            onChanged: (value) {
              selectedType = value!;
              context.read<ExpenseBloc>().add(FetchInitialExpenseEvent(filterFlag: value));
              setState(() {});
            },
          ),
        ),
        /*DropdownMenu(
                  inputDecorationTheme: InputDecorationTheme(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(21),
                    ),
                  ),
                  label: Text('Type'),
                  initialSelection: selectedType,
                  onSelected: (value) {
                    selectedType = value!;
                  },
                  dropdownMenuEntries: mType.map((eachType) {
                    return DropdownMenuEntry(value: eachType, label: eachType);
                  }).toList(),
                ),*/
      ],
    );
  }

  Widget mainLay(){
    return Expanded(
      child: BlocBuilder<ExpenseBloc, ExpenseState>(
        builder: (_, state) {
          if (state is ExpenseLoadingState) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is ExpenseErrorState) {
            return Center(child: Text(state.errorMsg));
          }

          if (state is ExpenseLoadedState) {
            return state.allExp.isNotEmpty
                ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Expense List',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: state.allExp.length,
                    itemBuilder: (_, index) {
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 11),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(11),
                          border: Border.all(
                            color: Colors.grey.shade400,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              SizedBox(height: 11),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    state.allExp[index].title,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    state.allExp[index].balance
                                        .toString(),
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16),
                              Container(
                                color: Colors.grey.shade400,
                                width: double.infinity,
                                height: 1,
                              ),
                              SizedBox(height: 5),
                              ListView.builder(
                                padding: EdgeInsets.zero,
                                physics:
                                NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: state
                                    .allExp[index]
                                    .eachTitleExp
                                    .length,
                                itemBuilder: (_, childIndex) {
                                  ExpenseModel eachExp = state
                                      .allExp[index]
                                      .eachTitleExp[childIndex];

                                  String imgPath = AppConstants.allCat
                                      .firstWhere((element) {
                                    return element.id ==
                                        eachExp.catId;
                                  })
                                      .imgPath;

                                  DateTime eachExpDate =
                                  DateTime.fromMillisecondsSinceEpoch(
                                    eachExp.createdAt,
                                  );

                                  return ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    leading: Container(
                                      padding: EdgeInsets.all(7),
                                      decoration: BoxDecoration(
                                        color: Colors
                                            .primaries[Random()
                                            .nextInt(
                                          Colors
                                              .primaries
                                              .length,
                                        )]
                                            .shade100,
                                        borderRadius:
                                        BorderRadius.circular(7),
                                      ),
                                      child: Image.asset(
                                        imgPath,
                                        width: 30,
                                        height: 30,
                                      ),
                                    ),
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
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            )
                : Center(child: Text('No Expenses yet!!'));
          }

          return Container();
        },
      ),
    );
  }
}
