import 'package:expenso_422/data/local/model/expense_model.dart';
import 'package:expenso_422/domain/constants/app_constants.dart';
import 'package:expenso_422/ui/custom_widgets/ui_helper.dart';
import 'package:expenso_422/ui/screen/add_expense/bloc/expense_bloc.dart';
import 'package:expenso_422/ui/screen/add_expense/bloc/expense_event.dart';
import 'package:expenso_422/ui/screen/add_expense/bloc/expense_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AddExpensePage extends StatefulWidget {
  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  var titleController = TextEditingController();

  var descController = TextEditingController();

  var amtController = TextEditingController();

  String selectedType = "Debit";
  List<String> mTypes = ["Debit", "Credit" /*, "Loan", "Lend", "Borrow"*/];

  int selectedCatIndex = -1;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  DateTime? selectedDateTime;
  DateFormat df = DateFormat();
  DateFormat tf = DateFormat.jms();

  ///1.add validation in add expense page
  ///2.add loader on loadingState when tapped on add expense
  ///3.use fetchInitialExpenseEvent and load all expenses in that UI

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('Add Expense')),
      body: Padding(
        padding: const EdgeInsets.all(11.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: myFieldDecoration(
                label: "Title",
                hint: "Enter your title here..",
              ),
            ),
            SizedBox(height: 11),
            TextField(
              controller: descController,
              decoration: myFieldDecoration(
                label: "Desc",
                hint: "Enter your desc here..",
              ),
            ),
            SizedBox(height: 11),
            TextField(
              keyboardType: TextInputType.number,
              controller: amtController,
              decoration: myFieldDecoration(
                label: "Amount",
                hint: "Enter your amount here..",
              ),
            ),
            SizedBox(height: 11),
            /*DropdownButton(
              value: selectedType,
                items: [
              DropdownMenuItem(value: "Debit", child: Text("Debit")),
              DropdownMenuItem(value: "Credit", child: Text("Credit")),
            ], onChanged: (value){
              selectedType = value!;
              setState(() {

              });
            }),*/
            DropdownMenu(
              width: double.infinity,
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
              dropdownMenuEntries: mTypes.map((eachType) {
                return DropdownMenuEntry(value: eachType, label: eachType);
              }).toList(),
            ),
            SizedBox(height: 11),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                minimumSize: Size(double.infinity, 55),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(21),
                ),
              ),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (_) {
                    return Container(
                      padding: EdgeInsets.all(16),
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: AppConstants.allCat.length,
                        itemBuilder: (_, index) {
                          return InkWell(
                            onTap: () {
                              selectedCatIndex = index;
                              setState(() {});
                              Navigator.pop(context);
                            },
                            child: Column(
                              children: [
                                Image.asset(
                                  AppConstants.allCat[index].imgPath,
                                  width: 50,
                                  height: 50,
                                ),
                                Text(AppConstants.allCat[index].title),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
              child: selectedCatIndex < 0
                  ? Text('Select Category')
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          AppConstants.allCat[selectedCatIndex].imgPath,
                          width: 30,
                          height: 30,
                        ),
                        Text(
                          " - ${AppConstants.allCat[selectedCatIndex].title}",
                        ),
                      ],
                    ),
            ),
            SizedBox(height: 11),
            StatefulBuilder(
              builder: (context, ss) {
                return OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size(double.infinity, 55),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(21),
                    ),
                  ),
                  onPressed: () async{
                    selectedDate = await showDatePicker(
                        context: context,
                        firstDate: DateTime.now().subtract(Duration(days: 365)),
                        lastDate: DateTime.now());

                    selectedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute)
                    );

                    DateTime userDate = selectedDate ?? DateTime.now();
                    TimeOfDay userTime = selectedTime ?? TimeOfDay.now();
                    selectedDateTime = DateTime(userDate.year, userDate.month, userDate.day, userTime.hour, userTime.minute);


                    ss((){});
                  },
                  child: Text(df.format(selectedDateTime ?? DateTime.now())),
                );
              }
            ),
            SizedBox(height: 11),
            /*StatefulBuilder(
                builder: (context, ss) {
                  return OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      minimumSize: Size(double.infinity, 55),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(21),
                      ),
                    ),
                    onPressed: () async{
                      selectedTime = await showTimePicker(
                          context: context,
                        initialTime: TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute)
                      );

                      ss((){});
                    },
                    child: Text((selectedTime?? TimeOfDay.now()).format(context)),
                  );
                }
            ),
            SizedBox(
              height: 11,
            ),*/
            BlocListener<ExpenseBloc, ExpenseState>(
              listener: (context, state) {
                if(state is ExpenseErrorState){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.errorMsg),
                      backgroundColor: Colors.red,
                    ),
                  );
                }

                if(state is ExpenseLoadedState){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Expense added successfully!!"),
                      backgroundColor: Colors.green,
                    ),
                  );
                  Navigator.pop(context);
                }
              },
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(21)
                  ),
                  backgroundColor: Colors.pink.shade200,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {

                  ///shared pref logic
                  context.read<ExpenseBloc>().add(
                    AddExpenseEvent(
                      newExp: ExpenseModel(
                        title: titleController.text,
                        desc: descController.text,
                        amt: double.parse(amtController.text),
                        bal: 0.0,
                        expType: selectedType=="Debit" ? 1 : 2,
                        catId: AppConstants.allCat[selectedCatIndex].id,
                        createdAt: (selectedDateTime ?? DateTime.now()).millisecondsSinceEpoch,
                      ),
                    ),
                  );
                },
                child: Text('Add Expense'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
