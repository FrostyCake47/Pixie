import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  String email = "";
  String password = "";
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Login({super.key});

  void login(){
    print("Email and pass is : " + email + "  " + password);
  }

  void editValueOnChange(String value, String str){
    if(str == "Email") email = value;
    else{password = value;}
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(children: [
            TextFields(controller: emailController, editValueOnChange: editValueOnChange, str: "Email",),
            TextFields(controller: passwordController, editValueOnChange: editValueOnChange, str: "Password",),
            LoginButton(login: login)
          ]),
        ),
      ),
    );
  }
}

class TextFields extends StatelessWidget {
  final TextEditingController controller;
  final Function(String, String) editValueOnChange;
  final String str;

  TextFields({super.key, required this.controller, required this.editValueOnChange, required this.str});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: str,
        hintStyle: TextStyle(color: Colors.white)
      ),
      style: const TextStyle(color: Colors.white),
      onChanged: (value){
        editValueOnChange(value, str);
      },
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
      child: const Text("   Login   ", style: TextStyle(color: Colors.white, fontSize: 20),));
  }
}