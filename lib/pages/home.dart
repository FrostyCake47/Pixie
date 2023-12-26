import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar,
      body: homeBody,
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
          CircleAvatar(radius: 12, child: Image(
            image: AssetImage('assets/PaperPlanes1.png')),
            )
        ],
      ),
    ),
  );

  Widget homeBody = Container();

