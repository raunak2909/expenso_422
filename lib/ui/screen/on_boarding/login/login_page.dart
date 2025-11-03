import 'package:expenso_422/domain/constants/app_routes.dart';
import 'package:expenso_422/ui/custom_widgets/app_rounded_btn.dart';
import 'package:expenso_422/ui/custom_widgets/ui_helper.dart';
import 'package:expenso_422/ui/screen/on_boarding/bloc/user_bloc.dart';
import 'package:expenso_422/ui/screen/on_boarding/bloc/user_event.dart';
import 'package:expenso_422/ui/screen/on_boarding/bloc/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  var emailController = TextEditingController();
  var passController = TextEditingController();

  bool isPasswordVisible = false;
  bool isLoading = false;
  bool isLogin = true;

  GlobalKey<FormState> mKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: mKey,
        child: Padding(
          padding: const EdgeInsets.all(11.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(' Hi, Welcome back', style: TextStyle(fontSize: 34)),
              SizedBox(height: 21),
              TextFormField(
                validator: (value) {
                  final bool emailValid = RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                  ).hasMatch(value ?? "");

                  if (value == null || value.isEmpty) {
                    return "Please enter your email";
                  } else if (!emailValid) {
                    return "Please enter a valid email";
                  } else {
                    return null;
                  }
                },
                controller: emailController,
                decoration: myFieldDecoration(
                  hint: "Enter your email here..",
                  label: "Email",
                ),
              ),
              SizedBox(height: 11),
              StatefulBuilder(
                builder: (context, ss) {
                  return TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your password";
                      } else {
                        return null;
                      }
                    },
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
              BlocConsumer<UserBloc, UserState>(
                listenWhen: (prev, curr){
                  return isLogin;
                },
                buildWhen: (prev, curr){
                  return isLogin;
                },
                listener: (_, state) {
                  if (state is UserLoadingState) {
                    isLoading = true;
                  }

                  if (state is UserFailureState) {
                    isLoading = false;
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.errorMsg), backgroundColor: Colors.red,));
                  }

                  if (state is UserSuccessState) {
                    isLoading = false;
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text("Logged-in successfully!!"), backgroundColor: Colors.green,));
                    Navigator.pushReplacementNamed(context, AppRoutes.dashboard);
                  }
                },
                builder: (context, state) {
                  return AppRoundedButton(
                    onTap: () {
                      if (mKey.currentState!.validate()) {
                        isLogin = true;
                        context.read<UserBloc>().add(
                          LoginUserEvent(
                            email: emailController.text,
                            pass: passController.text,
                          ),
                        );
                      }
                    },
                    title: "Login",
                    myChild: isLoading
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(color: Colors.white),
                              SizedBox(width: 11),
                              Text(
                                'Loading',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          )
                        : null,
                  );
                },
              ),
              SizedBox(height: 11),
              Center(
                child: InkWell(
                  onTap: () {
                    isLogin = false;
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
      ),
    );
  }
}
