import 'package:expenso_422/data/local/model/filter_expense_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartPage extends StatelessWidget {
  List<FilterExpenseModel> dummyData = [
    FilterExpenseModel(title: "Jan", balance: 20000, eachTitleExp: []),
    FilterExpenseModel(title: "Feb", balance: 40000, eachTitleExp: []),
    FilterExpenseModel(title: "Mar", balance: 25000, eachTitleExp: []),
    FilterExpenseModel(title: "Apr", balance: 15000, eachTitleExp: []),
    FilterExpenseModel(title: "May", balance: 70000, eachTitleExp: []),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 21),
        width: double.infinity,
        height: 250,
        color: Colors.pink.shade200,
        child: BarChart(BarChartData(
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (index, _){
                  return Text(dummyData[index.toInt()].title);
                }
              )
            )
          ),
          maxY: 100000,
          barGroups: List.generate(dummyData.length, (index){
            return BarChartGroupData(x: index, barRods: [
              BarChartRodData(toY: dummyData[index].balance.toDouble(), color: Colors.white),
            ]);
          }),
        )),
      ),
    );
  }
}
