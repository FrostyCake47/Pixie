import 'package:flutter/material.dart';
import 'package:diary/pages/home.dart';
import 'package:diary/pages/loading.dart';

void main() {
  runApp(MaterialApp(
      initialRoute: "/home",
      routes: {
        "/" : (context) => Loading(),
        "/home" : (context) => Home(),
      },

      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: Color.fromARGB(255, 28, 28, 28),
          appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 28, 28, 28),
          //backgroundColor: Colors.redAccent
        )
      ),
    )
  );
}
