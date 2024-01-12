import 'package:flutter/material.dart';
import 'package:diary/pages/Auth/login.dart';
import 'package:diary/components/pixietext.dart';
import 'package:diary/components/Auth/loginregister.dart';


class Register extends StatelessWidget {
  String email = "";
  String password = "";
  String confpassword = "";
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confpasswordController = TextEditingController();
  Register({super.key});

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
              const SizedBox(height: 30,),
              Pixie(),

              const SizedBox(height: 50,),
              TextFields(controller: emailController, editValueOnChange: editValueOnChange, str: "Email",),
              TextFields(controller: passwordController, editValueOnChange: editValueOnChange, str: "Password",),
              TextFields(controller: confpasswordController, editValueOnChange: editValueOnChange, str: "Confirm Password",),

              Container(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(onPressed: (){}, child: const Text("Forgot Password?")),
                  ],
                ),
              ),
              const SizedBox(height: 40,),

              Row(
                children: [
                  Expanded(child: Divider(thickness: 3, color: Colors.grey[800],)),
                  const Text("    Or Continue with    ", style: TextStyle(color: Colors.white),),
                  Expanded(child: Divider(thickness: 3, color: Colors.grey[800],)),
                ],
              ),

              const SizedBox(height: 30,),]),
            )
      ),
    );
  }
}