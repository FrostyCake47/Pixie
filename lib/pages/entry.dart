import 'package:flutter/material.dart';
import 'package:diary/services/entryblock.dart';

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
    //print("inside entry: ${instance.title ?? 'title' }");
    //print(instance?.date);

    //title = ModalRoute.of(context)!.settings.arguments as String?;
    String title = data?['title'] ?? "null";
    print(title);

    return Scaffold(
      appBar: AppBar(

      ),
      body: Center(
        child: Text(data?['title'],
        style: TextStyle(
          color: Colors.white
        ),
      ),),
    );
  }
}