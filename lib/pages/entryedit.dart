import 'package:diary/services/entryblock.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class EntryEdit extends StatefulWidget {
  const EntryEdit({super.key});

  @override
  State<EntryEdit> createState() => _EntryEditState();
}

class _EntryEditState extends State<EntryEdit> {
  late Map? data;

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)?.settings.arguments as Map?;
    
    return Scaffold(
      appBar: AppBar(),
      body: EntryEditBody(data: data)
    );
  }
}



class EntryEditBody extends StatelessWidget {
  late final Map? data;
  late EntryBlockDetails instance;
  late Box<EntryBlockDetails> _entryDetails;
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  EntryEditBody({super.key, required this.data});

  Future<void> _initializeHive() async {
    _entryDetails = Hive.box<EntryBlockDetails>('entrydetails');
    print("entryBlocks initalized");
  }

  void CreateInstance(){
    _initializeHive();
    instance = _entryDetails.get(data?['id']) ?? EntryBlockDetails(id: -1, title: "title", subtitle: "subtitle");
    _titleController = TextEditingController(text: instance.title);
    _contentController = TextEditingController(text: instance.content);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("wolah"),
    );
  }
}