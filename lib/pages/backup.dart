import 'package:diary/services/entryblock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hive/hive.dart';
import 'package:diary/services/databaseservice.dart';

class Backup extends StatefulWidget {

  Backup({super.key});

  @override
  State<Backup> createState() => _BackupState();
}

class _BackupState extends State<Backup> {
  late Box<EntryBlockDetails> _entryDetails;

  late List entryBlocks;

  void import() async {
  }

  void export() async {
    /*await _initializeHive();
    entryBlocks.forEach((instance) { 
      print(instance.title);
    });*/
    showDialog(context: context, builder: (context){
        return const Center(
            child: SpinKitCircle(
              color: Colors.redAccent,
              size: 50.0,
            ),
          );
      });
    
    DatabaseService().updateData();
    Navigator.pop(context);

  }

  Future<void> _initializeHive() async {
    _entryDetails = Hive.box<EntryBlockDetails>('entrydetails');
    Iterable<EntryBlockDetails> allEntries = _entryDetails.values;
    entryBlocks = allEntries.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back_rounded), color: Colors.white, onPressed: () async {Navigator.pop(context);}),),
      body: Column(
        children: [
          const Icon(Icons.cloud, color: Colors.white, size: 96,), 
          const Text("Backup your data", style: TextStyle(color: Colors.white, fontSize: 20),),
          const SizedBox(height: 60,),
          BlockyButton(text: "Import", subheading: "Loads in the diary entries that has been saved inside the cloud", ontap: import,),
          const SizedBox(height: 30,),
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
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          TextButton(
            onPressed: ontap,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(20)
            
              ), 
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 50),
              child: Text(text, style: const TextStyle(color: Colors.black),
              )
            ),
          ),
          const SizedBox(height: 20,),
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