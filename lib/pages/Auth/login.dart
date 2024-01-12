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
        body: SingleChildScrollView(
          child: Center(
            child: Column(children: [
              const SizedBox(height: 30,),
              const Text("Pixie", style: TextStyle(fontFamily: "LavishlyYours", color: Colors.white, fontSize: 72),),
              const SizedBox(height: 50,),
              TextFields(controller: emailController, editValueOnChange: editValueOnChange, str: "Email",),
              TextFields(controller: passwordController, editValueOnChange: editValueOnChange, str: "Password",),
              const SizedBox(height: 10,),
              LoginButton(login: login),
              const SizedBox(height: 10,),

              Container(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(onPressed: (){}, child: const Text("Click here to register")),
                  ],
                ),
              )
            ]),
          ),
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          hintText: str,
          hintStyle: const TextStyle(color: Colors.grey)
        ),
        style: const TextStyle(color: Colors.white),
        onChanged: (value){
          editValueOnChange(value, str);
        },
      ),
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