import 'package:diary/components/pixietext.dart';
import 'package:flutter/material.dart';
import 'package:diary/services/entryblock.dart';
import 'package:hive/hive.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Box<EntryBlockDetails> _entryDetails;
  late List<EntryBlockDetails> entryBlocks;

  late Box<int> _idTracker;
  late int currentID;
  int numba = 69;

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
    //_idTracker.clear();

  }

  Future<void> _initializeHive() async {
    _entryDetails = Hive.box<EntryBlockDetails>('entrydetails');
    Iterable<EntryBlockDetails> allEntries = _entryDetails.values;
    entryBlocks = allEntries.toList();
    //_entryDetails.clear();
    print("entryBlocks initalized");
  }

  void deleteItem(int id) {
    setState(() {
      id == -1 ? print("invalid id") : _entryDetails.delete(id);
      _initializeHive();
    });
  }

  void updateChange(bool changed){
    if(changed){
      setState(() {
        _initializeHive();
      });
    }
  }

  Future<void> _showInputDialog(BuildContext context) async {
    String newTitle = '';
    String newSubTitle = '';
    String content = '';

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentTextStyle: TextStyle(color: Colors.white),
          backgroundColor: Colors.grey[900],
          //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: SizedBox(height: 0,),
          
          content: TextField(
            style: const TextStyle(color: Colors.white),
            onChanged: (value) {
              newTitle = value;
            },
            decoration: InputDecoration(
              hintText: 'Enter a title',
              hintStyle: TextStyle(color: Colors.grey.shade400)
            ),
          ),


          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel', style: TextStyle(color: Colors.white),),
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
                  EntryBlock instanceblock = EntryBlock(parentContext: context, instance: instance, deleteItemCallback: deleteItem, updateChange: updateChange,);
                  
                  entryBlocks.add(instance);
                  _entryDetails.put(currentID, instance);
                  _idTracker.put(0, currentID);
                });
                Navigator.of(context).pop();
              },
              child: Text('OK', style: TextStyle(color: Colors.white),),
            ),
          ],

        
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(),
      body: HomeBody(entryBlocks: entryBlocks, deleteItem: deleteItem, updateChange: updateChange,),
            floatingActionButton: FloatingActionButton(onPressed: (){
              setState(() {
                _showInputDialog(context);
              });
            },
            child: const Icon(Icons.add),
            backgroundColor: Colors.grey[200]),
            
    );
  }
}


class HomeAppBar extends StatelessWidget implements PreferredSizeWidget{
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      iconTheme: const IconThemeData(color: Colors.white),
      titleTextStyle: const TextStyle(color: Colors.white),
      title: Center(
        child: Row(
          children: <Widget>[
            const Icon(Icons.book, size: 25),
            const SizedBox(width: 10,),
            const Expanded(child: Text("Pixie", style: TextStyle(fontSize: 25,),)),
            //Expanded(child: Pixie(sizey: 25,)),
            const Icon(Icons.search),
            const SizedBox(width: 10,),
            const CircleAvatar(radius: 15, backgroundImage: AssetImage('assets/PaperPlanes1.jpg'),
              ),
            IconButton(onPressed: (){
              Navigator.pushNamed(context, '/setting');
            }, icon: const Icon(Icons.settings), color: Colors.white,),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class HomeBody extends StatefulWidget {
  final List entryBlocks;
  final void Function(int) deleteItem;
  final void Function(bool) updateChange;

  const HomeBody({Key? key, required this.entryBlocks, required this.deleteItem, required this.updateChange}) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  Widget build(BuildContext context) {
    try{
      return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromARGB(255, 28, 28, 28), Color.fromARGB(255, 18, 18, 18)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
          )
        ),
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: ListView.builder(
          itemCount: widget.entryBlocks.length,
          itemBuilder: (context, index){
            print("currently in itembuilder");
            return EntryBlock(parentContext: context, instance: widget.entryBlocks[index], deleteItemCallback: widget.deleteItem, updateChange: widget.updateChange,);  
          },
          padding: const EdgeInsets.symmetric(horizontal: 10),  
        ),
      );
    }
    catch (e) {
      if (e is RangeError) {
        print('Caught a RangeError(Empty app): $e');
      } 
      else {
        print('An error occurred: $e');
      }

      return Container();
    };
  }
}