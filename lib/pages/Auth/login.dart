import 'package:diary/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:diary/components/pixietext.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:diary/components/Auth/loginregister.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Login extends StatefulWidget {
  late dynamic togglePage;

  Login(Function? togglePagee){
    togglePage = togglePagee ?? (){};
  }

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email = "";
  String password = "";
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  //testuser@gmail.com   testpass

  void login() async {
    print("Email and pass is : " + email + "  " + password);
    try {
      showDialog(context: context, builder: (context){
        return const Center(
            child: SpinKitCircle(
              color: Colors.redAccent,
              size: 50.0,
            ),
          );
      });
      
      try{
        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      }
      on FirebaseAuthException catch(e){
        if(e.code == "user-not-found"){
          print("user not found");
        }
        else if(e.code == "wrong-password"){
          print("email or password is wrong");
        }
      }
      
      Navigator.pop(context);

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
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

              /*Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AuthButton(text: "Register", action: widget.togglePage),
                  AuthButton(text: "Login", action: login,),
                ],
              ),*/
              AuthButton(text: "Login", action: login,),
              const SizedBox(height: 50,),

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
              ),

              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Dont have an account? ", style: TextStyle(color: Colors.white),),
                  GestureDetector(
                    onTap: widget.togglePage,
                    child: Text("Register", style: const TextStyle(color: Colors.blue),),
                  ),
                ],
              )
            ]),
          ),
        ),
    );
  }
}



