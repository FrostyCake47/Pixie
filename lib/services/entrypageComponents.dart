import 'package:diary/services/entryblock.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';



class EntryDateTime extends StatefulWidget {
  final Map? data;
  const EntryDateTime({Key? key, this.data}) : super(key: key);

  @override
  State<EntryDateTime> createState() => _EntryDateTimeState();
}

class _EntryDateTimeState extends State<EntryDateTime> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(widget.data?['day'] + " · "  + widget.data?['date'] + "  |  " +  widget.data?['time'] ,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.grey
          ),
        ),
        Text("#${widget.data!['id']}",
        style: const TextStyle(
            fontSize: 15,
            color: Colors.grey
          ),
        )
      ],
    );
  }
}


class EntryTitle extends StatefulWidget {
  final Map? data;
  const EntryTitle({Key? key, this.data}) : super(key: key);

  @override
  State<EntryTitle> createState() => _EntryTitleState();
}

class _EntryTitleState extends State<EntryTitle> {
  
  @override
  Widget build(BuildContext context) {
    return Text(widget.data?['title'],
      style: const TextStyle(
        fontSize: 30,
        color: Colors.white
      ),
    );
  }
}


class WrittenContent extends StatefulWidget {
  Map? data;
  String initialContent;


  WrittenContent({Key? key, this.initialContent = "lets see", required this.data}) : super(key: key);

  @override
  State<WrittenContent> createState() => _WrittenContentState();
}

class _WrittenContentState extends State<WrittenContent> {
  late TextEditingController _textEditingController;
  bool _isEditing = false;
  late Box<EntryBlockDetails> _entryDetails;
  late EntryBlockDetails instance;

  Future<void> _initializeHive() async {
    _entryDetails = Hive.box<EntryBlockDetails>('entrydetails');

  }
  
  int loadInstance(Map? data) {
    instance = _entryDetails.get(data?["id"]) ?? EntryBlockDetails(id: -1, title: "title", subtitle: "subtitle");
    return instance.id;
  }

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController(text: widget.initialContent);
    _initializeHive();
  }

  void _toggleEditing() {
    setState(() {
      print("toggled editing");
      _isEditing = !_isEditing;
    });
  }

  void createInstanceBlock(){
    instance = EntryBlockDetails(
      id: widget.data?['id'], 
      title: widget.data?['title'], 
      subtitle: widget.data?['subtitle'],
      date: widget.data?['date'],
      day: widget.data?['day'],
      time: widget.data?['time'],
      content: widget.initialContent);

    _entryDetails.put(widget.data?['id'], instance);
  }

  void _saveChanges() {
    createInstanceBlock();
    _toggleEditing();
    print("after saving content of instance content ${instance.content}");
  }

  @override
  Widget build(BuildContext context) {
    /*return Expanded(
      child: Text(widget.data?['content']));*/
    if(loadInstance(widget.data) != -1){
      widget.initialContent = instance.content;
    };

    return Container(
      child: _isEditing
            ? Container(
              decoration: BoxDecoration(
                color: Colors.grey[500],
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                      SingleChildScrollView(
                        child: TextField(
                          controller: _textEditingController,
                          onChanged: (value) {
                            widget.initialContent = value;
                          },
                                    
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.zero
                          ),
                          maxLines: 15,
                          keyboardType: TextInputType.multiline,
                          style: const TextStyle(fontSize: 18.0, color: Colors.white),
                          textAlign: TextAlign.left,
                        ),
                      ),
              
                    ElevatedButton(
                      onPressed: _saveChanges,
                      child: const Text('Save Changes'),
                    ),                  
                  ],
                ),
            )
            : SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.redAccent[200],
                ),
                child: GestureDetector(
                    onTap: _toggleEditing,
                    child: Container(
                      child: Text(
                        widget.initialContent,
                        style: TextStyle(fontSize: 18.65, color: Colors.white),
                      ),
                    ),
                  ),
              ),
            ),
      );
  }
}

