import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EntryBlock extends StatelessWidget {
  final String title;
  final String subtitle;
  late String date;
  late String time;

  EntryBlock({Key? key, required this.title, required this.subtitle}): super(key: key){
    DateTime now = DateTime.now();
    date = DateFormat('d MMM').format(now);
    time = DateFormat.jm().format(now).toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.grey[900],
      ),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: Text(date),
        tileColor: Colors.grey[400],
        
        titleTextStyle: const TextStyle(
          fontSize: 20,
          color: Colors.white,
        ),
        subtitleTextStyle: const TextStyle(
          color: Colors.grey,
        ),
        leadingAndTrailingTextStyle: const TextStyle(
          color: Colors.grey,
        ),
      ),
    );
  }
}