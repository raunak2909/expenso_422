import 'package:expenso_422/data/local/helper/db_helper.dart';
import 'package:expenso_422/domain/constants/app_routes.dart';
import 'package:expenso_422/ui/screen/on_boarding/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///signUp complete
///login implement
///session maintain using prefs
///add logout feature


void main() {
  runApp(
    BlocProvider(
      create: (context) => UserBloc(dbHelper: DBHelper.getInstance()),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: AppRoutes.splash,
      routes: AppRoutes.mRoutes(),
    );
  }
}
