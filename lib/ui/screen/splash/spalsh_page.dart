import 'dart:async';

import 'package:expenso_422/domain/constants/app_constants.dart';
import 'package:expenso_422/domain/constants/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  
  @override
  void initState() {
    super.initState();
    
    Timer(Duration(seconds: 4,), () async {

      SharedPreferences prefs = await SharedPreferences.getInstance();
      int userId = prefs.getInt(AppConstants.pref_user_id) ?? 0;

      String nextPage = AppRoutes.login;

      if(userId>0){
        nextPage = AppRoutes.dashboard;
      }

      Navigator.pushReplacementNamed(context, nextPage);
    });
    
    
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppConstants.img_app_logo, width: 200, height: 200),
            SizedBox(height: 11),
            Text(
              'Expenso',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
