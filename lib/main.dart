import 'package:flutter/material.dart';
import 'package:diary/pages/home.dart';
import 'package:diary/pages/loading.dart';
import 'package:diary/pages/entry.dart';

void main() {
  runApp(MaterialApp(
      initialRoute: "/home",
      routes: {
        "/" : (context) => Loading(),
        "/home" : (context) => Home(),
        "/entry" : (context) => Entry(),
      },

      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 28, 28, 28),
          appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 28, 28, 28),
          //backgroundColor: Colors.redAccent
        )
      ),
    )
  );
}
