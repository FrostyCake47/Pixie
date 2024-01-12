import 'package:diary/pages/Auth/login.dart';
import 'package:diary/pages/setting.dart';
import 'package:flutter/material.dart';
import 'package:diary/pages/home.dart';
import 'package:diary/pages/loading.dart';
import 'package:diary/pages/entry.dart';
import 'package:diary/pages/entryedit.dart';
import 'package:diary/pages/Auth/password.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:diary/services/entryblock.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
  );


  await Hive.initFlutter();
  Hive.registerAdapter(EntryBlockDetailsAdapter());
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);

  print("setting entryDetails in main.dart");
  var entryDetails = await Hive.openBox<EntryBlockDetails>('entrydetails');
  var idTracker = await Hive.openBox<int>("idtracker");
  var passlock = await Hive.openBox<String>("passlock");


  runApp(MaterialApp(
      initialRoute: "/pass",
      routes: {
        "/" : (context) => const Loading(),
        "/home" : (context) => const Home(),
        "/entry" : (context) => const Entry(),
        "/entryedit" : (context) => const EntryEdit(),
        "/pass" : (context) => const PasswordPage(),
        "/setting" : (context) => const Setting(),
        "/login" : (context) => Login(),
      },

      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 28, 28, 28),
          appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 28, 28, 28),
          titleTextStyle: TextStyle(color: Colors.white),
        )
      ),
    )
  );
}
