import 'package:flutter/material.dart';
import 'package:diary/services/entryblock.dart';
import 'package:diary/services/entrypageComponents.dart';
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
    return Scaffold(
      appBar: const EntryAppBar(),
      body: EntryBody(data:data)
    );
  }
}

class EntryAppBar extends StatelessWidget implements PreferredSizeWidget {
  const EntryAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(
        color: Colors.white
      ),
    );;
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}


class EntryBody extends StatelessWidget {
  final Map? data;
  const EntryBody({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: const BoxDecoration(),
      child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
          EntryDateTime(data: data,),
          const SizedBox(height: 5,),
          EntryTitle(data: data,)
        ],
      ),
    );
  }
}
