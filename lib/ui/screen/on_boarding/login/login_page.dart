import 'package:expenso_422/domain/constants/app_routes.dart';
import 'package:expenso_422/ui/custom_widgets/app_rounded_btn.dart';
import 'package:expenso_422/ui/custom_widgets/ui_helper.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  var emailController = TextEditingController();
  var passController = TextEditingController();

  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(11.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(' Hi, Welcome back', style: TextStyle(fontSize: 34)),
            SizedBox(height: 21),
            TextField(
              controller: emailController,
              decoration: myFieldDecoration(
                hint: "Enter your email here..",
                label: "Email",
              ),
            ),
            SizedBox(height: 11),
            StatefulBuilder(
              builder: (context, ss) {
                return TextField(
                  controller: passController,
                  obscureText: !isPasswordVisible,
                  decoration: myFieldDecoration(
                    hint: "Enter your password here..",
                    label: "Password",
                    isPassword: true,
                    isPasswordVisible: isPasswordVisible,
                    onPasswordVisibilityTap: () {
                      isPasswordVisible = !isPasswordVisible;
                      ss(() {});
                    },
                  ),
                );
              },
            ),
            SizedBox(height: 21),
            AppRoundedButton(onTap: () {}, title: "Login"),
            SizedBox(height: 11),
            Center(
              child: InkWell(
                onTap: (){
                  Navigator.pushNamed(context, AppRoutes.signup);
                },
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Don't have an account? ",
                        style: TextStyle(color: Colors.black),
                      ),
                      TextSpan(
                        text: "Create now..",
                        style: TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
