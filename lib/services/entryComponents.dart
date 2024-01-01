import 'package:flutter/material.dart';



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


class EntryTitle extends StatefulWidget {
  final Map? data;
  const EntryTitle({Key? key, this.data}) : super(key: key);

  @override
  State<EntryTitle> createState() => _EntryTitleState();
}

class _EntryTitleState extends State<EntryTitle> {
  
  @override
  Widget build(BuildContext context) {
    return Text("${widget.data!['id']} " + widget.data?['title'],
      style: const TextStyle(
        fontSize: 30,
        color: Colors.white
      ),
    );
  }
}


class WrittenContent extends StatefulWidget {
  final Map? data;

  const WrittenContent({Key? key, this.data}) : super(key: key);

  @override
  State<WrittenContent> createState() => _WrittenContentState();
}

class _WrittenContentState extends State<WrittenContent> {
  @override
  Widget build(BuildContext context) {
    /*return Expanded(
      child: Text(widget.data?['content']));*/

    return Column(
      children: <Widget>[
        FloatingActionButton(onPressed: (){

        })
      ],
    );
  }
}