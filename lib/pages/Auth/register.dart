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
      on FirebaseAuthException catch (e){
        /*setState(() {
          error = e.code;
        });*/
        print(e.code);
      }
      catch (e){
        print(e.toString());
      }
    }

  }

  void doNothing(){}

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        leading: IconButton(
          onPressed: widget.togglePage,
          icon: const Icon(Icons.arrow_back_rounded),
              color: Colors.white,)
      ),
      body: SingleChildScrollView(
          child: Center(
            child: Column(children: [
              //const SizedBox(height: 30,),
              Pixie(),

              const SizedBox(height: 10,),
              Text(error, style: const TextStyle(color: Colors.redAccent),),
              const SizedBox(height: 10,),
              TextFields(controller: emailController, editValueOnChange: editValueOnChange, str: "Email",),
              TextFields(controller: passwordController, editValueOnChange: editValueOnChange, str: "Password",),
              TextFields(controller: confpasswordController, editValueOnChange: editValueOnChange, str: "Confirm Password",),
              const SizedBox(height: 28,),

              /*Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AuthButton(text: "Login", action: widget.togglePage),
                  AuthButton(text: "Sign-up", action: signup),
                ],
              ),*/
              AuthButton(text: "Sign-up", action: signup),
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
              ),

              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account? ", style: TextStyle(color: Colors.white),),
                  GestureDetector(
                    onTap: widget.togglePage,
                    child: Text("Login", style: const TextStyle(color: Colors.blue),),
                  ),
                ],
              )
            ]
          )
        )
      ),
    );
  }
}