import 'package:expenso_422/ui/screen/dashboard/dashboard_page.dart';
import 'package:expenso_422/ui/screen/on_boarding/login/login_page.dart';
import 'package:expenso_422/ui/screen/on_boarding/signup/signup_page.dart';
import 'package:expenso_422/ui/screen/splash/spalsh_page.dart';
import 'package:flutter/cupertino.dart';

import '../../ui/screen/add_expense/add_expense_page.dart';

class AppRoutes{

  static const String splash = "/";
  static const String login = "/login";
  static const String signup = "/signUp";
  static const String dashboard = "/dashboard";
  static const String addExpense = "/addExpense";
  static const String stats = "/stats";

  static Map<String, WidgetBuilder> mRoutes() => {
    splash : (_) => SplashPage(),
    login : (_) => LoginPage(),
    signup : (_) => SignupPage(),
    dashboard : (_) => DashboardPage(),
    addExpense : (_) => AddExpensePage(),
  };


}