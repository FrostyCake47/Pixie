import 'package:diary/pages/auth/login.dart';
import 'package:diary/pages/auth/register.dart';
import 'package:flutter/material.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool isLoginPage = true;

  void togglePage(){
    setState(() {
      isLoginPage = !isLoginPage;
    });
  }
  

  @override
  Widget build(BuildContext context) {
    if(isLoginPage) return Login(togglePage);
    else return Register(togglePage);
  }
}