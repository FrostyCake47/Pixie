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
  late EntryBlockDetails instance;
  late Box<EntryBlockDetails> _entryDetails;

  Future<void> _initializeHive() async {
    _entryDetails = Hive.box<EntryBlockDetails>('entrydetails');
    print("entryBlocks initalized");
  }

  void createInstance(){
    _initializeHive();
    instance = _entryDetails.get(data?['id']) ?? EntryBlockDetails(id: -1, title: "title", subtitle: "subtitle");
  }

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)?.settings.arguments as Map?;
    createInstance();
    
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(onPressed: (){

            }, 
            icon: const Icon(Icons.check), color: Colors.white,),
          ],),),
      body: EntryEditBody(instance: instance,)
    );
  }
}



class EntryEditBody extends StatelessWidget {
  late EntryBlockDetails instance;
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  EntryEditBody({super.key, required this.instance});

  void CreateControllers(){
    _titleController = TextEditingController(text: instance.title);
    _contentController = TextEditingController(text: instance.content);
  }

  @override
  Widget build(BuildContext context) {
    CreateControllers();

    return Container(
      
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: const BoxDecoration(),
      child:SingleChildScrollView(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(instance.day + " · "  + instance.date + "  |  " +  instance.time ,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.grey
                    ),
                  ),
                  Text("#${instance.id}",
                  style: const TextStyle(
                      fontSize: 15,
                      color: Colors.grey
                    ),
                  )
                ],
              ),

              Text(instance.title,
                style: const TextStyle(
                  fontSize: 30,
                  color: Colors.white
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}