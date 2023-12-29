import 'package:flutter/material.dart';
import 'package:diary/services/entryblock.dart';
//import 'package:diary/services/database.txt';

class Entry extends StatefulWidget {
  const Entry({super.key});

  @override
  State<Entry> createState() => _EntryState();
}

class _EntryState extends State<Entry> {
  Map? data = {};

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)?.settings.arguments as Map?;
    //String filename = data?['date']+data?['time'];
    //print(filename); 

    AppBar entryAppbar = AppBar(
      iconTheme: const IconThemeData(
        color: Colors.white
      ),
    );

    Widget entryBody = Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
      ),
      child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
          EntryDateTime(data: data,),
          const SizedBox(height: 5,),
          EntryTitle(data: data,)
        ],
      ),
    );

    return Scaffold(
      appBar: entryAppbar,
      body: entryBody
    );
  }

  

  

}

