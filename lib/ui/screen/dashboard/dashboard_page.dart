/// A page that displays the main dashboard of the app.
///
/// This page contains a bottom navigation bar that allows the user to switch
/// between different pages, such as the home page, stats page, and profile page.
import 'package:expenso_422/domain/constants/app_constants.dart';
import 'package:expenso_422/domain/constants/app_routes.dart';
import 'package:expenso_422/ui/screen/dashboard/nav_pages/nav_home_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'nav_pages/nav_noti_page.dart';
import 'nav_pages/nav_profile_page.dart';
import 'nav_pages/nav_stats_page.dart';

/// A page that displays the main dashboard of the app.
///
/// This page contains a bottom navigation bar that allows the user to switch
/// between different pages, such as the home page, stats page, and profile page.
class DashboardPage extends StatefulWidget {
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

/// The state for the [DashboardPage].
class _DashboardPageState extends State<DashboardPage> {
  /// The index of the currently selected page in the bottom navigation bar.
  int selectedIndex = 0;

  /// The list of pages that can be displayed in the dashboard.
  List<Widget> myPages = [
    NavHomePage(),
    NavStatsPage(),
    Container(),
    NavNotiPage(),
    NavProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("Monety"),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.search)),
          IconButton(
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setInt(AppConstants.pref_user_id, 0);

              Navigator.pushReplacementNamed(context, AppRoutes.login);
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: myPages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 26,
        selectedItemColor: Colors.pink.shade200,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if(index==2){
            Navigator.pushNamed(context, AppRoutes.addExpense);
          } else {
            selectedIndex = index;
            setState(() {});
          }
        },
        currentIndex: selectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_outlined),
            label: "Stats",
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: EdgeInsets.all(11),
              decoration: BoxDecoration(
                color: Colors.pink.shade200,
                borderRadius: BorderRadius.circular(11)
              ),
              child: Icon(Icons.add, color: Colors.white,),
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_active_outlined),
            label: "Notifications",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
