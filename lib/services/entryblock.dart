import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EntryBlock extends StatelessWidget {
  final String title;
  final String subtitle;
  late final String date;
  late final String time;
  late final String day;

  EntryBlock({Key? key, required this.title, required this.subtitle}): super(key: key){
    DateTime now = DateTime.now();
    date = DateFormat('d MMM').format(now);
    time = DateFormat.jm().format(now).toString();
    day = DateFormat.E('en_US').format(now);
    print(day);
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

        onTap: () async {
          await Navigator.pushNamed(context, '/entry', arguments: {
            'title': title, 
            'subtitle': subtitle, 
            'date': date, 
            'time': time,
            'day' : day,
          });
        },
        
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


class EntryTitle extends StatefulWidget {
  final Map? data;
  const EntryTitle({Key? key, this.data}) : super(key: key);

  @override
  State<EntryTitle> createState() => _EntryTitleState();
}

class _EntryTitleState extends State<EntryTitle> {
  
  @override
  Widget build(BuildContext context) {
    return Text(widget.data?['title'],
      style: const TextStyle(
        fontSize: 30,
        color: Colors.white
      ),
    );
  }
}


class EntryDateTime extends StatefulWidget {
  final Map? data;
  const EntryDateTime({Key? key, this.data}) : super(key: key);

  @override
  State<EntryDateTime> createState() => _EntryDateTimeState();
}

class _EntryDateTimeState extends State<EntryDateTime> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.data?['day'] + " · "  + widget.data?['date'] + "  |  " +  widget.data?['time'],
      style: const TextStyle(
        fontSize: 15,
        color: Colors.grey
      ),
    );
  }
}