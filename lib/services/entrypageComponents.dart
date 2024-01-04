import 'package:flutter/material.dart';



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
  String initialContent;

  WrittenContent({Key? key, required this.initialContent}) : super(key: key);

  @override
  State<WrittenContent> createState() => _WrittenContentState();
}

class _WrittenContentState extends State<WrittenContent> {
  late TextEditingController _textEditingController;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController(text: widget.initialContent);
  }

  void _toggleEditing() {
    setState(() {
      print("toggled editing");
      _isEditing = !_isEditing;
    });
  }

  void _saveChanges() {
    // Save the changes to your data model or storage here
    // For example, you can update the content in your database or file
    // ...
    //widget.initialContent = 
    // After saving, exit the editing mode
    _toggleEditing();
  }

  @override
  Widget build(BuildContext context) {
    /*return Expanded(
      child: Text(widget.data?['content']));*/

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

