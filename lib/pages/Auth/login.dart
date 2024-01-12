import 'package:flutter/material.dart';
import 'package:diary/services/pixietext.dart';

class Login extends StatelessWidget {
  String email = "";
  String password = "";
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Login({super.key});

  void login(){
    print("Email and pass is : " + email + "  " + password);
  }

  void register(){
    print("go to register page");
  }

  void editValueOnChange(String value, String str){
    if(str == "Email") email = value;
    else{password = value;}
  }

  void doNothing(){}
  


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Center(
            child: Column(children: [
              const SizedBox(height: 30,),
              Pixie(),

              const SizedBox(height: 50,),
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
              const SizedBox(height: 30,),

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
      ),
    );
  }
}



class TextFields extends StatelessWidget {
  final TextEditingController controller;
  final Function(String, String) editValueOnChange;
  final String str;

  const TextFields({super.key, required this.controller, required this.editValueOnChange, required this.str});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: TextField(
        obscureText: str == "Password" ? true : false,
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

class AuthButton extends StatelessWidget {
  final String text;
  final Function() action;
  const AuthButton({super.key, required this.text ,required this.action});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: const ButtonStyle(
    
        backgroundColor: MaterialStatePropertyAll<Color>(Color.fromARGB(255, 255, 23, 68))
      ),
      onPressed: action, 
      child: Text("   $text   ", style: const TextStyle(color: Colors.white, fontSize: 20),));
  }
}


class ImageButton extends StatelessWidget {
  final String imageURL;
  final void Function()? onPressed;
  const ImageButton({super.key, required this.imageURL, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.symmetric(vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5)
      ),
      //child: Image.asset(imageURL, height: 40, width: 40,)
      child: IconButton(icon: Container(child: Image.asset(imageURL), height: 40, width: 40,), onPressed: onPressed)
    );
  }
}