import 'package:diary/services/entryblock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:diary/services/databaseservice.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:restart_app/restart_app.dart';

class Backup extends StatefulWidget {

  Backup({super.key});

  @override
  State<Backup> createState() => _BackupState();
}

class _BackupState extends State<Backup> {
  late Box<EntryBlockDetails> _entryDetails;

  late List entryBlocks;

  void import() async {
    Map<String, dynamic> data;
    showDialog(context: context, builder: (context){
        return const Center(
            child: SpinKitCircle(
              color: Colors.redAccent,
              size: 50.0,
            ),
          );
      });
    
    data = await DatabaseService().readData();
    Navigator.pop(context);
    
    

    if(data['hasError'] == true){Fluttertoast.showToast(msg: "You haven't previously backedup to cloud before");}
    else {
      // ignore: use_build_context_synchronously
      await CoolAlert.show(
        context: context,
        type: CoolAlertType.confirm,
        title: "Import contents?",
        text: "This will modify your current local files and replace them with cloud save",
        onConfirmBtnTap: () async {
          await DatabaseService().overrideLocalSave(data);
          await Fluttertoast.showToast(msg: "Your contents has been imported");
          Fluttertoast.showToast(msg: "Restart your app now", toastLength: Toast.LENGTH_LONG);
        },
      );
    
    }
  }

  void export() async {
    showDialog(context: context, builder: (context){
        return const Center(
            child: SpinKitCircle(
              color: Colors.redAccent,
              size: 50.0,
            ),
          );
      });
    
    await DatabaseService().updateData();
    Navigator.pop(context);
    Fluttertoast.showToast(msg: "Your contents has been saved to the cloud");
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