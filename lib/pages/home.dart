import 'package:flutter/material.dart';
import 'package:diary/services/entryblock.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List entryBlocks = [
    EntryBlock(title: "mwaa", subtitle: "lmao what?"),
    EntryBlock(title: "idk lmao", subtitle: "what else to write here?"),];

  Widget? getEntryBlocks(context, index, List entryBlocks){
    return entryBlocks[index];
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar,
      body: homeBody(entryBlocks)
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
    return ListView.builder(
      itemCount: entryBlocks.length,
      itemBuilder: (context, index){
        return entryBlocks[index];
      },
      
    );
}
