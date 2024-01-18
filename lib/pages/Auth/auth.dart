import 'package:diary/pages/auth/login.dart';
import 'package:diary/pages/auth/loginorregister.dart';
import 'package:diary/pages/home.dart';
import 'package:diary/pages/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if(snapshot.hasData) {
            print("I habe data");
            return Home();
            }
          else {
            return LoginOrRegister();
          }
        },
      ),
    );
  }
}