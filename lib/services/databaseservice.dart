import 'package:diary/services/entryblock.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

class DatabaseService{
  final CollectionReference userscollection = FirebaseFirestore.instance.collection('users');
  final FirebaseAuth auth = FirebaseAuth.instance;
  late User? user;
  late Map<String, dynamic> map = {};

  late Box<EntryBlockDetails> _entryDetails;
  late List<EntryBlockDetails> entryBlocks;

  late Box _idTracker;
  late int currentId;


  DatabaseService(){
    _initializeHive();
    _initializeidTracker();
    user = auth.currentUser;
  }

  Future<void> updateData() async {
    createMap();
    return await userscollection.doc(user!.uid).set(map);
  }

  Future<Map<String, dynamic>> readData() async {
    map['hasError'] = false;
    try {
      await FirebaseFirestore.instance
      .collection('users')
      .doc(user!.uid)
      .get()
      .then((DocumentSnapshot documentSnapshot){
          if(documentSnapshot.data() == null) {print('aa error true'); map['hasError'] = true;}
          else{
            map = documentSnapshot.data() as Map<String, dynamic>;  
            print(map['entryblocks'][0]['id']);
            print(map['entryblocks'][0]['id'].runtimeType);
          }
      }
    );
    return map;

    } catch (error) {
      print('Error reading data: $error');
      map['hasError'] = true;
      return map;
    }
  }

  Future<void> overrideLocalSave(Map<String, dynamic> data) async {
    EntryBlock instance;
    //_idTracker.put(0, map['idtracker']);
    //print('new idtracker' + map['idtracker']);

    /*map['entryblocks'].forEach((value){
      print(value);
    });*/

    //print(map['entryblocks']);

  }

  void createMap(){
    List entryDetailList = [];
    entryBlocks.forEach((instance) { 
      entryDetailList.add(
        {
          'id' : instance.id,
          'title' : instance.title,
          'subtitle' : instance.subtitle,
          'day' : instance.day,
          'time' : instance.time,
          'date' : instance.date,
          'content' : instance.content
        }
      );
    });

    map = {
      'idtracker' : currentId,
      'entryblocks' : entryDetailList,
    };

    //print(map);
  }

  void _initializeHive() {
    _entryDetails = Hive.box<EntryBlockDetails>('entrydetails');
    Iterable<EntryBlockDetails> allEntries = _entryDetails.values;
    entryBlocks = allEntries.toList();
  }

  void _initializeidTracker() {
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