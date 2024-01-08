import 'package:flutter/material.dart';
import 'package:diary/pages/home.dart';
import 'package:diary/pages/loading.dart';
import 'package:diary/pages/entry.dart';
import 'package:diary/pages/entryedit.dart';
import 'package:diary/pages/password.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:diary/services/entryblock.dart';


Future<void> main() async{
  await Hive.initFlutter();
  Hive.registerAdapter(EntryBlockDetailsAdapter());

  // Get the application documents directory
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);

  // Open boxes
  print("setting entryDetails in main.dart");
  var entryDetails = await Hive.openBox<EntryBlockDetails>('entrydetails');
  var idTracker = await Hive.openBox<int>("idtracker");
  var passlock = await Hive.openBox<String>("passlock");
  //var entryContents = await Hive.openBox<EntryBlock>('entrycontents');


  runApp(MaterialApp(
      initialRoute: "/pass",
      routes: {
        "/" : (context) => Loading(),
        "/home" : (context) => Home(),
        "/entry" : (context) => Entry(),
        "/entryedit" : (context) => EntryEdit(),
        "/pass" : (context) => PasswordPage(),
      },

      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 28, 28, 28),
          appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 28, 28, 28),
          titleTextStyle: TextStyle(color: Colors.white),
          //toolbarTextStyle: TextStyle(color: Colors.white),
          
          //backgroundColor: Colors.redAccent
        )
      ),
    )
  );
}
