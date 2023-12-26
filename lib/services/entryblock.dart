import 'package:flutter/material.dart';

class EntryBlock extends StatelessWidget {
  String title;
  String subtitle;

  EntryBlock({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10)
      ),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        tileColor: Colors.grey[400],
        
        titleTextStyle: const TextStyle(
          fontSize: 20,
          color: Colors.white,
        ),
      ),
    );
  }
}