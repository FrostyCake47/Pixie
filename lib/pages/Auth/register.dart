import 'package:diary/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:diary/pages/Auth/login.dart';
import 'package:diary/components/pixietext.dart';
import 'package:diary/components/Auth/loginregister.dart';



class Register extends StatefulWidget {
  late dynamic togglePage;

  Register(Function? togglePagee){
    togglePage = togglePagee ?? (){};
  }

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String email = "";
  String password = "";
  String confpassword = "";
  String error = "";
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confpasswordController = TextEditingController();

  void editValueOnChange(String value, String str){
    if(str == "Email") email = value;
    else if(str == "Password"){password = value;}
    else if(str == "Confirm Password"){confpassword = value;}
  }

  Future<void> signup() async {
    if(password.trim() == confpassword.trim()){
      print("perfect homie" + password + confpassword);
      try{
        FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      }
      catch (e){
        setState(() {
          error = "Uh ooh";
        });
      }
    }

  }

  void doNothing(){}

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
          child: Center(
            child: Column(children: [
              //const SizedBox(height: 30,),
              Pixie(),

              const SizedBox(height: 15,),
              Text(error, style: const TextStyle(color: Colors.white),),
              const SizedBox(height: 15,),
              TextFields(controller: emailController, editValueOnChange: editValueOnChange, str: "Email",),
              TextFields(controller: passwordController, editValueOnChange: editValueOnChange, str: "Password",),
              TextFields(controller: confpasswordController, editValueOnChange: editValueOnChange, str: "Confirm Password",),
              const SizedBox(height: 28,),

              Row(
                children: [
                  AuthButton(text: "Login", action: widget.togglePage),
                  AuthButton(text: "Sign-up", action: signup),
                ],
              ),

              const SizedBox(height: 28,),

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
                  ImageButton(imageURL: "assets/google.png", onPressed: () => AuthService().signInWithGoogle()),
                  ImageButton(imageURL: "assets/apple-64.png", onPressed: doNothing),
                ],
              )
            ]
          )
        )
      ),
    );
  }
}