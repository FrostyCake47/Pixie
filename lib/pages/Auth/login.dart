import 'package:flutter/material.dart';
import 'package:diary/components/pixietext.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:diary/components/Auth/loginregister.dart';

class Login extends StatefulWidget {

  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email = "";
  String password = "";
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login(){
    print("Email and pass is : " + email + "  " + password);
  }

  void register(){
    print("go to register page");
    Navigator.pushNamed(context, "/register");
  }

  void editValueOnChange(String value, String str){
    if(str == "Email") email = value;
    else{password = value;}
  }

  void doNothing(){}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Center(
            child: Column(children: [
              const SizedBox(height: 0,),
              Pixie(),

              const SizedBox(height: 40,),
              TextFields(controller: emailController, editValueOnChange: editValueOnChange, str: "Email",),
              TextFields(controller: passwordController, editValueOnChange: editValueOnChange, str: "Password",),

              Container(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(onPressed: (){}, child: const Text("Forgot Password?")),
                  ],
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AuthButton(text: "Register", action: register),
                  AuthButton(text: "Login", action: login,),
                ],
              ),
              const SizedBox(height: 80,),

              Row(
                children: [
                  Expanded(child: Divider(thickness: 3, color: Colors.grey[800],)),
                  const Text("    Or Continue with    ", style: TextStyle(color: Colors.white),),
                  Expanded(child: Divider(thickness: 3, color: Colors.grey[800],)),
                ],
              ),

              const SizedBox(height: 30,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ImageButton(imageURL: "assets/google.png", onPressed: doNothing),
                  ImageButton(imageURL: "assets/apple-64.png", onPressed: doNothing),
                ],
              )

              
            ]),
          ),
        ),
    );
  }
}



