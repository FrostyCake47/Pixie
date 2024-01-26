import 'package:diary/services/entryblock.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';



class EntryDateTime extends StatelessWidget {
  final Map? data;
  const EntryDateTime({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(data?['day'] + " · "  + data?['date'] + "  |  " +  data?['time'] ,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.grey
          ),
        ),
        Text("#${data!['id']}",
        style: const TextStyle(
            fontSize: 15,
            color: Colors.grey
          ),
        )
      ],
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


class WrittenContent extends StatefulWidget {
  Map? data;
  WrittenContent({Key? key, required this.data}) : super(key: key);

  @override
  State<WrittenContent> createState() => _WrittenContentState();
}

class _WrittenContentState extends State<WrittenContent> {
  late Box<EntryBlockDetails> _entryDetails;
  late EntryBlockDetails instance;

  Future<void> _initializeHive() async {
    _entryDetails = Hive.box<EntryBlockDetails>('entrydetails');

  }
  
  void loadInstance(Map? data) {
    instance = _entryDetails.get(data?["id"]) ?? EntryBlockDetails(id: -1, title: "title", subtitle: "subtitle");
  }

  @override
  void initState() {
    super.initState();
    _initializeHive();
    loadInstance(widget.data);
  }

  @override
  Widget build(BuildContext context) { 
    //print("/"+instance.content+"/");
    return Container(
      child: SingleChildScrollView(
              child: Container(
                child: Container(
                  child: instance.content != '      ' ?
                    Text(
                      instance.content,
                      style: TextStyle(fontSize: 18.65, color: Colors.white),
                    ) : 
                    const Text(
                      "Dear diary...",
                      style: TextStyle(fontSize: 18.65, color: Colors.grey),
                    ),
                ),
              ),
            ),
      );
  }
}