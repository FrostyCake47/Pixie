import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    String email;
    String password;
    TextEditingController emailController;
    TextEditingController passwordController;


    return const Scaffold(
      body: Center(
        child: Column(children: [


        ]),
      ),
    );
  }
}

class TextFields extends StatelessWidget {
  final TextEditingController controller;
  const TextFields({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
    );
  }
}

class LoginButton extends StatelessWidget {
  final Function() login;
  const LoginButton({super.key, required this.login});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: const ButtonStyle(
        backgroundColor: MaterialStatePropertyAll<Color>(Color.fromARGB(255, 255, 23, 68))
      ),
      onPressed: login, 
      child: Text("Login"));
  }
}