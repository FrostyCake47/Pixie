import 'package:flutter/material.dart';
import 'package:diary/services/entryblock.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List entryBlocks = [
    EntryBlock(title: "mwaa", subtitle: "lmao what?"),
    EntryBlock(title: "idk lmao", subtitle: "what else to write here?"),];

  Future<void> _showInputDialog(BuildContext context) async {
    String newTitle = '';
    String newSubTitle = '';

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
                  entryBlocks.add(EntryBlock(title: newTitle, subtitle: newSubTitle));
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
    return Container(
      child: ListView.builder(
        itemCount: entryBlocks.length,
        itemBuilder: (context, index){
          return entryBlocks[index];
        },
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        
      ),
    );
}
