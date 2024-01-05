import 'package:flutter/material.dart';
import 'package:diary/services/entryblock.dart';
import 'package:diary/services/entrypageComponents.dart';
import 'package:hive/hive.dart';
//import 'package:diary/services/database.txt';



class Entry extends StatefulWidget {
  const Entry({super.key});

  @override
  State<Entry> createState() => _EntryState();
}

class _EntryState extends State<Entry> {
  late Map? data = {};
  late EntryBlockDetails? instance;
  late Box<EntryBlockDetails> _entryDetails;

  Future<void> _initializeHive() async {
    _entryDetails = Hive.box<EntryBlockDetails>('entrydetails');
  }

  void updateData(){
    _initializeHive();
    instance = _entryDetails.get(data?['id']) ?? EntryBlockDetails(id: -1, title: "title", subtitle: "subtitle");
    data?['title'] = instance?.title ?? "title";
    data?['content'] = instance?.content ?? "content";
  }

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)?.settings.arguments as Map?;
    updateData();
    return Scaffold(
      appBar: EntryAppBar(data:data),
      body: EntryBody(data:data)
    );
  }
}

class EntryAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Map? data;
  const EntryAppBar({super.key, required this.data});
  

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(
        color: Colors.white
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(onPressed: (){
            Navigator.pushNamed(context, "/entryedit", arguments: {
                    'id': data?['id'],
            });
          }, 
          icon: const Icon(Icons.edit, color: Colors.white,))
        ],
      ),
      
    );
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
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: const BoxDecoration(),
      child:SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
            EntryDateTime(data: data,),
            const SizedBox(height: 10),
            EntryTitle(data: data,),
            const SizedBox(height: 10),
            WrittenContent(data:data),
          ],
        ),
      ),
    );
  }
}