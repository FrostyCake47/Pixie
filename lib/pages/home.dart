import 'package:flutter/material.dart';
import 'package:diary/services/entryblock.dart';
import 'package:hive/hive.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  /*List entryBlocks = [
    EntryBlock(title: "mwaa", subtitle: "lmao what?", id: 1,),
    EntryBlock(title: "idk lmao", subtitle: "what else to write here?", id: 2,),];
  */

  late Box<EntryBlockDetails> _entryDetails;
  late List<EntryBlockDetails> entryBlocks;

  late Box<int> _idTracker;
  late int currentID;

  _HomeState() {
    print("initialzing hive");
    _initializeHive();
    _initializeIdTracker();
  }
  

  Future<void> _initializeIdTracker() async {
    _idTracker = Hive.box<int>('idtracker');
    if(_idTracker.get(0) == null){
      await _idTracker.put(0, 0);
      currentID = 0;
    }
    else{
      currentID = _idTracker.get(0) as int;
    } 
  }

  Future<void> _initializeHive() async {
    _entryDetails = Hive.box<EntryBlockDetails>('entrydetails');

    Iterable<EntryBlockDetails> allEntries = _entryDetails.values;
    
    
    entryBlocks = allEntries.toList();
    print("entryBlocks initalized");
  }


  Future<void> _showInputDialog(BuildContext context) async {
    String newTitle = '';
    String newSubTitle = '';
    String content = '';

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter Title'),
          content: TextField(
            onChanged: (value) {
              newTitle = value;
            },
            decoration: const InputDecoration(
              hintText: 'Enter a title',
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: (){
                print('User input: $newTitle');
                setState(() {
                  currentID += 1;
                  //EntryBlock instance = EntryBlock(title: newTitle, subtitle: newSubTitle, id: 1,);
                  print("going to create instance");
                  EntryBlockDetails instance = EntryBlockDetails(id: currentID, title: newTitle, subtitle: currentID.toString());
                  print("going to create instanceblock");
                  EntryBlock instanceblock = EntryBlock(instance: instance);
                  
                  entryBlocks.add(instance);

                  _entryDetails.put(currentID, instance);
                  _idTracker.put(0, currentID);
                });
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar,
      body: homeBody(entryBlocks),
            floatingActionButton: FloatingActionButton(onPressed: (){
              setState(() {
                _showInputDialog(context);
              });
            },
            child: const Icon(Icons.add),),   
    );
  }
}

  AppBar homeAppBar = AppBar(
    automaticallyImplyLeading: false,
    iconTheme: const IconThemeData(color: Colors.white),
    titleTextStyle: const TextStyle(color: Colors.white),
    title: const Center(
      child: Row(
        children: <Widget>[
          Icon(Icons.book,),
          SizedBox(width: 10,),
          Expanded(child: Text("My Diary")),
          Icon(Icons.search),
          SizedBox(width: 10,),
          CircleAvatar(radius: 10, child: Image(
            image: AssetImage('assets/PaperPlanes1.jpg')),
            )
        ],
      ),
    ),
  );

  Widget homeBody(List entryBlocks){
    print("currently in homebody");
    print(entryBlocks[0]);
    print(entryBlocks[0].title);
    print(entryBlocks[0].date);
    return Container(
      child: ListView.builder(
        itemCount: entryBlocks.length,
        itemBuilder: (context, index){
          print("currently in itembuilder");
          return EntryBlock(instance: entryBlocks[index]);  

        },
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        
      ),
    );
}
