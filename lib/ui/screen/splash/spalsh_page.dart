import 'dart:async';

import 'package:expenso_422/domain/constants/app_constants.dart';
import 'package:expenso_422/domain/constants/app_routes.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  
  @override
  void initState() {
    super.initState();
    
    Timer(Duration(seconds: 4,), (){
      Navigator.pushReplacementNamed(context, AppRoutes.login);
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
