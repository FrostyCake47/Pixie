import 'package:diary/services/entryblock.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

class DatabaseService{
  //final String uid;
  final CollectionReference userscollection = FirebaseFirestore.instance.collection('users');
  final FirebaseAuth auth = FirebaseAuth.instance;
  late User? user;
  late Map<String, dynamic> map;

  late Box<EntryBlockDetails> _entryDetails;
  late List<EntryBlockDetails> entryBlocks;

  late Box _idTracker;
  late int currentId;


  Future<void> updateData() async {
    await _initializeHive();
    await _initializeidTracker();

    entryBlocks.forEach((instance) { 
      print(instance.title);
    });
  }

  Future<void> _initializeHive() async {
    _entryDetails = Hive.box<EntryBlockDetails>('entrydetails');
    Iterable<EntryBlockDetails> allEntries = _entryDetails.values;
    entryBlocks = allEntries.toList();
  }

  Future<void> _initializeidTracker() async {
    _idTracker = Hive.box<int>('idtracker');
      if(_idTracker.get(0) == null){
        currentId = 0;
      }
      else{
        currentId = _idTracker.get(0) as int;
      }
  }

  /*Future<void> updateData() async {
    user = auth.currentUser;

    Map<String, dynamic> map = {
      'idtracker' : 6,
      'entryblocks' : [
        {
          'id' : 1,
          'title' : 'newtitle',
          'subtitle' : 'newsubtitle',
          'day' : 'Wed',
          'time' : '2:33 pm',
          'date' : '26 Jan',
          'content' : "hello this is just testing for fun lmao"
        },

        {
          'id' : 2,
          'title' : 'mwaaa',
          'subtitle' : 'newsubtitle',
          'day' : 'Thu',
          'time' : '5:33 pm',
          'date' : '27 Jan',
          'content' : "idk what to type here"
        },
      ]
    };

    return await userscollection.doc(user!.uid).set(map);
  }*/
}