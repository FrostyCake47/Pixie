import 'package:flutter/material.dart';

class Backup extends StatelessWidget {
  const Backup({super.key});

  void import() async {
    print("importing mwaaa");
  }

  void export() async {
    print("exporting mwaaa");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back_rounded), color: Colors.white, onPressed: () async {Navigator.pop(context);}),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          BlockyButton(text: "Import", subheading: "Loads in the diary entries that has been saved inside the cloud", ontap: import,),
          BlockyButton(text: "Export", subheading: "Uploads your entries into the cloud",ontap: export,),   
        ],
      ),
    );
  }
}


class BlockyButton extends StatelessWidget {
  final String text;
  final String subheading;
  final void Function()? ontap;
  const BlockyButton({super.key, required this.text, required this.subheading ,required this.ontap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(20)),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          GestureDetector(
            onTap: ontap,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(20)
            
              ), 
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 50),
              child: Text(text, style: const TextStyle(color: Colors.black),
              )
            ),
          ),
          SizedBox(height: 20,),
          Center(
            child: Text(subheading,
              style: 
                const TextStyle(color: Colors.white), 
                textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}